// lib/login/login_widgets.dart

import 'package:flutter/material.dart';

// Login form fields widget
class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  // Global key to uniquely identify the form and enable validation
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage the text in the fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: _inputDecoration.copyWith(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email, color: Colors.white70),
            ),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            // Validator to ensure the email field is not empty
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null; // Return null if the input is valid
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: _inputDecoration.copyWith(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock, color: Colors.white70),
            ),
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            // Validator to ensure the password field is not empty
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Validate the form before attempting to log in
              if (_formKey.currentState!.validate()) {
                // If the form is valid, proceed with login logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logging in...')),
                );
                // TODO: Add Firebase login logic and navigation
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB57F3A),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Log In', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  // Input decoration is now a private member of the state class
  final InputDecoration _inputDecoration = InputDecoration(
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white54),
    errorStyle: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
    ),
  );
}

// Social login buttons widget (unchanged)
class SocialLoginButtons extends StatelessWidget {
  final Color googleColor;
  final Color phoneColor;
  
  const SocialLoginButtons({
    super.key,
    required this.googleColor,
    required this.phoneColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // TODO: Add Google sign-in logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google Sign-in clicked')),
            );
          },
          icon: const Icon(Icons.login, color: Colors.white),
          label: const Text('Continue with Google', style: TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(
            backgroundColor: googleColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () {
            // TODO: Add Phone Number sign-in logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Phone number sign-in clicked')),
            );
          },
          icon: const Icon(Icons.phone, color: Colors.white),
          label: const Text('Continue with Phone Number', style: TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(
            backgroundColor: phoneColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        
        TextButton(
                  onPressed: () {
                    // TODO: Navigate to Forgot Password Page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigate to Forgot Password')),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),

      ],
    );
  }
}