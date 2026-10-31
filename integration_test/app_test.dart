// integration_test/app_test.dart
// Integration tests for RegistAgro Consumer - run against real API
// Run: flutter test integration_test/app_test.dart --dart-define=API_BASE_URL=https://api-registagro.onrender.com

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:projecto_registagro/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('RegistAgro Consumer - Integration Tests', () {
    testWidgets('App launches and shows home screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app starts
      expect(find.byType(app.MyApp), findsOneWidget);
    });

    testWidgets('Login flow with valid credentials', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login if needed
      // Fill email
      // Fill password
      // Tap login
      // Verify navigation to MainPage
      // This test requires real backend credentials
    });

    testWidgets('Product listing loads', (WidgetTester tester) async {
      // Requires authenticated session
      // Navigate to Store tab
      // Verify products appear
    });

    testWidgets('Order creation flow', (WidgetTester tester) async {
      // Requires authenticated session + products
      // Select product
      // Choose quantity
      // Confirm order
      // Verify reference generated
    });

    testWidgets('Profile loads and can edit', (WidgetTester tester) async {
      // Requires authenticated session
      // Navigate to Profile tab
      // Verify user data displayed
      // Edit profile
      // Verify changes saved
    });
  });
}