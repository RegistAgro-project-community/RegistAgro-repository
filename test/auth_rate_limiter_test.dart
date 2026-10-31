// tests for auth_rate_limiter
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projecto_registagro/services/auth_rate_limiter.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('AuthRateLimiter', () {
    late MockSharedPreferences mockPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    group('canAttempt', () {
      test('returns true for new identifier', () async {
        final can = await AuthRateLimiter.canAttempt('test@example.com');
        expect(can, isTrue);
      });

      test('returns false when locked out', () async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        await prefs.setInt(key, 5);
        await prefs.setInt('${key}_locked', DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch);

        final can = await AuthRateLimiter.canAttempt('test@example.com');
        expect(can, isFalse);
      });

      test('returns true when lockout expired', () async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        await prefs.setInt(key, 5);
        await prefs.setInt('${key}_locked', DateTime.now().subtract(const Duration(minutes: 10)).millisecondsSinceEpoch);

        final can = await AuthRateLimiter.canAttempt('test@example.com');
        expect(can, isTrue);
      });

      test('returns false when max attempts reached but not locked', () async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        await prefs.setInt(key, 5);

        final can = await AuthRateLimiter.canAttempt('test@example.com');
        expect(can, isFalse);
      });
    });

    group('recordAttempt', () {
      test('removes key on success', () async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        await prefs.setInt(key, 3);

        await AuthRateLimiter.recordAttempt('test@example.com', true);

        final attempts = prefs.getInt(key);
        expect(attempts, isNull);
      });

      test('increments attempts on failure', () async {
        await AuthRateLimiter.recordAttempt('test@example.com', false);
        await AuthRateLimiter.recordAttempt('test@example.com', false);

        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        final attempts = prefs.getInt(key);
        expect(attempts, 2);
      });

      test('locks after max attempts', () async {
        for (var i = 0; i < 5; i++) {
          await AuthRateLimiter.recordAttempt('test@example.com', false);
        }

        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        final lockedUntil = prefs.getInt('${key}_locked');
        expect(lockedUntil, isNotNull);
        expect(lockedUntil! > DateTime.now().millisecondsSinceEpoch, isTrue);
      });
    });

    group('getRemainingMinutes', () {
      test('returns null when not locked', () async {
        final mins = await AuthRateLimiter.getRemainingMinutes('test@example.com');
        expect(mins, isNull);
      });

      test('returns minutes when locked', () async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'auth_attempts_test@example.com';
        await prefs.setInt(key, 5);
        await prefs.setInt('${key}_locked', DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch);

        final mins = await AuthRateLimiter.getRemainingMinutes('test@example.com');
        expect(mins, greaterThan(0));
        expect(mins, lessThanOrEqualTo(10));
      });
    });

    group('getRemainingAttempts', () {
      test('returns max attempts for new identifier', () async {
        final remaining = await AuthRateLimiter.getRemainingAttempts('test@example.com');
        expect(remaining, 5);
      });

      test('returns decremented attempts', () async {
        await AuthRateLimiter.recordAttempt('test@example.com', false);
        await AuthRateLimiter.recordAttempt('test@example.com', false);

        final remaining = await AuthRateLimiter.getRemainingAttempts('test@example.com');
        expect(remaining, 3);
      });

      test('returns 0 when max reached', () async {
        for (var i = 0; i < 5; i++) {
          await AuthRateLimiter.recordAttempt('test@example.com', false);
        }

        final remaining = await AuthRateLimiter.getRemainingAttempts('test@example.com');
        expect(remaining, 0);
      });
    });
  });
}