// lib/services/auth_rate_limiter.dart
// Rate limit UI para login: 5 tentativas / 15 min lockout local

import 'package:shared_preferences/shared_preferences.dart';

class AuthRateLimiter {
  static const _maxAttempts = 5;
  static const _lockoutMinutes = 15;
  static const _keyPrefix = 'auth_attempts_';

  static Future<bool> canAttempt(String identifier) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$identifier';
    final attempts = prefs.getInt(key) ?? 0;
    final lockedUntil = prefs.getInt('${key}_locked') ?? 0;

    if (lockedUntil > DateTime.now().millisecondsSinceEpoch) {
      return false; // Ainda bloqueado
    }

    // Se lockout expirou, limpar tentativas
    if (lockedUntil > 0 && lockedUntil <= DateTime.now().millisecondsSinceEpoch) {
      await prefs.remove(key);
      await prefs.remove('${key}_locked');
      return true;
    }

    return attempts < _maxAttempts;
  }

  static Future<void> recordAttempt(String identifier, bool success) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$identifier';

    if (success) {
      await prefs.remove(key);
      await prefs.remove('${key}_locked');
    } else {
      final attempts = (prefs.getInt(key) ?? 0) + 1;
      await prefs.setInt(key, attempts);

      if (attempts >= _maxAttempts) {
        final lockUntil = DateTime.now().add(Duration(minutes: _lockoutMinutes)).millisecondsSinceEpoch;
        await prefs.setInt('${key}_locked', lockUntil);
      }
    }
  }

  static Future<int?> getRemainingMinutes(String identifier) async {
      final prefs = await SharedPreferences.getInstance();
      final lockedUntil = prefs.getInt('${_keyPrefix}$identifier\_locked') ?? 0;
      if (lockedUntil > DateTime.now().millisecondsSinceEpoch) {
        return ((lockedUntil - DateTime.now().millisecondsSinceEpoch) / 60000).ceil();
      }
      return null;
    }

  static Future<int> getRemainingAttempts(String identifier) async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = prefs.getInt('$_keyPrefix$identifier') ?? 0;
    return (_maxAttempts - attempts).clamp(0, _maxAttempts);
  }
}