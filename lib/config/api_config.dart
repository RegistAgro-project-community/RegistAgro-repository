// lib/config/api_config.dart
// Configuração centralizada de URLs da API via --dart-define
// Build: flutter build apk --dart-define=API_BASE_URL=https://api-registagro.onrender.com

class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.18.7:80',
  );

  static const String turnstileSiteKey = String.fromEnvironment(
    'TURNSTILE_SITE_KEY',
    defaultValue: '',
  );

  // Auth endpoints
  static const String consumerLogin = '$baseUrl/auth/login/consumer';
  static const String consumerSignup = '$baseUrl/auth/signup/consumer';
  static const String consumerVerifyOtpGet = '$baseUrl/auth/signup/verify'; // GET with email query + code path
  static const String consumerVerifyOtpPost = '$baseUrl/auth/signup/verify'; // POST with body
  static const String refreshToken = '$baseUrl/auth/refresh';
  static const String logout = '$baseUrl/auth/logout';

  // Orders endpoints
  static const String consumerOrders = '$baseUrl/orders/consumers/order/sent';
  static const String consumerCompleteOrder = '$baseUrl/flow/consumer/complete/order';
  static const String createOrder = '$baseUrl/orders/create/farm';
  static const String paymentConfirm = '$baseUrl/orders/payment/confirm';
  static const String cancelOrder = '$baseUrl/orders/consumers/cancel/order';
  static const String updateOrder = '$baseUrl/orders/consumers/update/order';
  static const String deleteOrder = '$baseUrl/orders/consumers/delete/order';

  // Products endpoints
  static const String consumerProducts = '$baseUrl/products/consumers/get/products';
  static const String farmProducts = '$baseUrl/products/consumers/get/farm';
  static const String productDetail = '$baseUrl/products/consumers/product';

  // Location endpoints
  static const String carrierCoordinates = '$baseUrl/location/get/coordinates/order';

  // Profile endpoints
  static const String userProfile = '$baseUrl/users/profile';
  static const String updateProfile = '$baseUrl/users/update';
  static const String uploadProfilePhoto = '$baseUrl/users/upload/profile';
  static const String deleteAccount = '$baseUrl/users/delete';

  // Token endpoints
  static const String tokenVerify = '$baseUrl/token';

  // Health endpoints
  static const String health = '$baseUrl/health';
  static const String ready = '$baseUrl/ready';
}