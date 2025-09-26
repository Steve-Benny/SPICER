// lib/login/customer_login_page.dart

import 'package:flutter/material.dart';
import 'package:spicer/login/login_page.dart';
import 'package:spicer/login/login_widgets.dart'; // Import the new widgets file

class CustomerLoginPage extends StatelessWidget {
  const CustomerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E4620),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Customer Login', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement( // Use pushReplacement to remove InitialPage from stack
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.shopping_cart, color: Color(0xFF3A5EB5), size: 100),
              const SizedBox(height: 10),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Log in to trace spices and support farmers.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),

              // Use the public LoginFields widget
              const LoginFields(),

              const SizedBox(height: 30),

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

              // Use the public SocialLoginButtons widget
              const SocialLoginButtons(
                googleColor: Color(0xFF3A5EB5),
                phoneColor: Color(0xFFB57F3A),
              ),
            ],
          ),
        ),
      ),
    );
  }
}