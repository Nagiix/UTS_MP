import 'package:flutter/material.dart';
import 'create_user_page.dart';
import 'forgot_password_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
        .hasMatch(email);
  }

  void login() {
    FocusScope.of(context).unfocus(); // tutup keyboard

    if (formKey.currentState!.validate()) {
      if (emailController.text == "admin@gmail.com" &&
          passwordController.text == "1234") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DashboardPage(username: emailController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email atau password salah")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: 60),

                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Masuk untuk melanjutkan",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  SizedBox(height: 40),

                  // EMAIL
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email wajib diisi";
                      }
                      if (!isValidEmail(value)) {
                        return "Format email tidak valid";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).nextFocus();
                    },
                  ),

                  SizedBox(height: 16),

                  // PASSWORD
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObscure,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password wajib diisi";
                      }
                      return null;
                    },

                    // 🔥 ENTER = SUBMIT LOGIN
                    onFieldSubmitted: (_) {
                      login();
                    },
                  ),

                  SizedBox(height: 24),

                  // LOGIN BUTTON
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text("Login"),
                    ),
                  ),

                  SizedBox(height: 10),

                  // FORGOT PASSWORD
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text("Lupa password?"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateUserPage(),
                        ),
                      );
                    },
                    child: Text("Buat user baru"),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "admin@gmail.com / 1234",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
