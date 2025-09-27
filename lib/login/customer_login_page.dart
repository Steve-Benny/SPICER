// lib/login/farmer_login_page.dart

import 'package:flutter/material.dart';
import 'package:spicer/customer_dashboard/customer_dashboard.dart';
import 'package:spicer/customer_dashboard/customer_sign_up_page.dart';
import 'package:spicer/login/login_page.dart';
import 'package:spicer/login/login_widgets.dart';


class CustomerLoginPage extends StatelessWidget {
  const CustomerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E4620), // Dark green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Customer Login', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement( // Use pushReplacement to go back to the selection page
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Farmer Icon
              const Icon(Icons.grass, color: Color(0xFFB57F3A), size: 100),
              const SizedBox(height: 10),
              const Text(
                'Join the Spicer Community!',
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Log in to connect with farmers for authentic Spices.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),

              // Reusable login fields (Now handles validation logic)
              const _LoginFields(),

              const SizedBox(height: 30),

              // Divider
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white54)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR', style: TextStyle(color: Colors.white54)),
                  ),
                  Expanded(child: Divider(color: Colors.white54)),
                ],
              ),
              const SizedBox(height: 30),

              // Reusable social login buttons
              const SocialLoginButtons(
                googleColor: Color(0xFFB57F3A),
                phoneColor: Color(0xFF3A5EB5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable widget for login form fields (Converted to StatefulWidget for validation)
class _LoginFields extends StatefulWidget {
  const _LoginFields();

  @override
  State<_LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<_LoginFields> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Input decoration setup (includes error styles)
  final InputDecoration _inputDecoration = const InputDecoration(
    labelStyle: TextStyle(color: Colors.white70),
    hintStyle: TextStyle(color: Colors.white54),
    errorStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // 1. Trigger validation
    if (_formKey.currentState!.validate()) {
      // 2. Form is valid! Perform login logic here (e.g., Firebase)

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Validation successful! Logging in...')),
      );

      // 3. Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerDashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 1. Email Field (Required + Validation)
          TextFormField(
            controller: _emailController,
            decoration: _inputDecoration.copyWith(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email, color: Colors.white70),
            ),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              // Simple email format check
              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // 2. Password Field (Required + 6-character validation)
          TextFormField(
            controller: _passwordController,
            decoration: _inputDecoration.copyWith(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock, color: Colors.white70),
            ),
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // 3. Log In Button
          ElevatedButton(
            onPressed: _handleLogin, // Calls the validation and navigation logic
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB57F3A),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Log In', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 20),
          // 4. Sign Up Link
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CustomerSignUpPage()),
              );
            },
            child: const Text(
              'New here? Sign Up',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}