import 'package:flutter/material.dart';
import 'screens/dashboard_page.dart';
import 'screens/forgot_password_page.dart';
import 'screens/login_page.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => LoginPage(),
        AppRoutes.forgotPassword: (_) => ForgotPasswordPage(),
        AppRoutes.dashboard: (_) => DashboardPage(username: ""),
      },
    );
  }
}
