// lib/validators/auth_validators.dart
// Validação client-side mínima (UX) - backend já tem Zod strictObject

class AuthValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email obrigatório';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Senha obrigatória';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) return 'Código obrigatório';
    if (value.length != 6) return 'Código deve ter 6 dígitos';
    if (!RegExp(r'^\d{6}$').hasMatch(value)) return 'Apenas números';
    return null;
  }

  static String? validateNif(String? value) {
    if (value == null || value.isEmpty) return 'NIF obrigatório';
    if (value.length != 9 || !RegExp(r'^\d{9}$').hasMatch(value)) {
      return 'NIF deve ter 9 dígitos';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Telefone obrigatório';
    if (value.length != 9 || !RegExp(r'^\d{9}$').hasMatch(value)) {
      return 'Telefone deve ter 9 dígitos';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '$fieldName obrigatório';
    return null;
  }
}
