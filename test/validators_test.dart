// tests for validators
import 'package:flutter_test/flutter_test.dart';
import 'package:projecto_registagro/validators/auth_validators.dart';

void main() {
  group('AuthValidators', () {
    group('validateEmail', () {
      test('returns error for null', () {
        expect(AuthValidators.validateEmail(null), 'Email obrigatório');
      });

      test('returns error for empty string', () {
        expect(AuthValidators.validateEmail(''), 'Email obrigatório');
      });

      test('returns error for invalid format', () {
        expect(AuthValidators.validateEmail('invalid'), 'Email inválido');
        expect(AuthValidators.validateEmail('invalid@'), 'Email inválido');
        expect(AuthValidators.validateEmail('@domain.com'), 'Email inválido');
      });

      test('returns null for valid emails', () {
        expect(AuthValidators.validateEmail('user@domain.com'), isNull);
        expect(AuthValidators.validateEmail('user.name@domain.co'), isNull);
        expect(AuthValidators.validateEmail('user+tag@domain.org'), isNull);
      });
    });

    group('validatePassword', () {
      test('returns error for null', () {
        expect(AuthValidators.validatePassword(null), 'Senha obrigatória');
      });

      test('returns error for empty string', () {
        expect(AuthValidators.validatePassword(''), 'Senha obrigatória');
      });

      test('returns error for short password', () {
        expect(AuthValidators.validatePassword('1234567'), 'Mínimo 8 caracteres');
      });

      test('returns null for valid password', () {
        expect(AuthValidators.validatePassword('12345678'), isNull);
        expect(AuthValidators.validatePassword('password123'), isNull);
      });
    });

    group('validateOtp', () {
      test('returns error for null', () {
        expect(AuthValidators.validateOtp(null), 'Código obrigatório');
      });

      test('returns error for empty string', () {
        expect(AuthValidators.validateOtp(''), 'Código obrigatório');
      });

      test('returns error for wrong length', () {
        expect(AuthValidators.validateOtp('12345'), 'Código deve ter 6 dígitos');
        expect(AuthValidators.validateOtp('1234567'), 'Código deve ter 6 dígitos');
      });

      test('returns error for non-numeric', () {
        expect(AuthValidators.validateOtp('abcdef'), 'Apenas números');
        expect(AuthValidators.validateOtp('12a456'), 'Apenas números');
      });

      test('returns null for valid OTP', () {
        expect(AuthValidators.validateOtp('123456'), isNull);
        expect(AuthValidators.validateOtp('000000'), isNull);
      });
    });

    group('validateNif', () {
      test('returns error for null', () {
        expect(AuthValidators.validateNif(null), 'NIF obrigatório');
      });

      test('returns error for wrong length', () {
        expect(AuthValidators.validateNif('12345678'), 'NIF deve ter 9 dígitos');
        expect(AuthValidators.validateNif('1234567890'), 'NIF deve ter 9 dígitos');
      });

      test('returns error for non-numeric', () {
        expect(AuthValidators.validateNif('12345678a'), 'NIF deve ter 9 dígitos');
      });

      test('returns null for valid NIF', () {
        expect(AuthValidators.validateNif('123456789'), isNull);
      });
    });

    group('validatePhone', () {
      test('returns error for null', () {
        expect(AuthValidators.validatePhone(null), 'Telefone obrigatório');
      });

      test('returns error for wrong length', () {
        expect(AuthValidators.validatePhone('12345678'), 'Telefone deve ter 9 dígitos');
      });

      test('returns error for non-numeric', () {
        expect(AuthValidators.validatePhone('12345678a'), 'Telefone deve ter 9 dígitos');
      });

      test('returns null for valid phone', () {
        expect(AuthValidators.validatePhone('923456789'), isNull);
      });
    });

    group('validateRequired', () {
      test('returns error for null', () {
        expect(AuthValidators.validateRequired(null, 'Campo'), 'Campo obrigatório');
      });

      test('returns error for empty', () {
        expect(AuthValidators.validateRequired('', 'Campo'), 'Campo obrigatório');
      });

      test('returns null for valid', () {
        expect(AuthValidators.validateRequired('value', 'Campo'), isNull);
      });
    });
  });
}