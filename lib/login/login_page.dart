// lib/login_page.dart

import 'package:flutter/material.dart';
import 'package:spicer/login/customer_login_page.dart';
import 'package:spicer/login/farmer_login_page.dart';
// You'll eventually import your FarmerLoginPage and CustomerLoginPage here

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E4620), // Dark green background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Spicer Logo (reuse from InitialPage, ideally as an Image.asset)
            // For now, using the text version again:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.grass, color: Colors.white, size: 30),
                const SizedBox(width: 8),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Colors.lightGreenAccent],
                  ).createShader(bounds),
                  child: const Text(
                    'SPICER',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.qr_code_2_sharp, color: Colors.white, size: 20),
              ],
            ),
            const SizedBox(height: 40),

            // Welcome Text
            const Text(
              'Welcome to the Spicer Community',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Are you a...?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 50),

            // Farmer Login Button
            _buildLoginOptionButton(
              context: context,
              icon: Icons.grass_outlined, // Leaf icon for farmer
              label: 'Farmer Login',
              backgroundColor: const Color(0xFFB57F3A), // Brownish-orange
              onPressed: () {
                Navigator.pushReplacement( // Use pushReplacement to remove InitialPage from stack
                  context,
                  MaterialPageRoute(builder: (context) => const FarmerLoginPage()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Customer Login Button
            _buildLoginOptionButton(
              context: context,
              icon: Icons.shopping_cart, // Shopping cart icon for customer
              label: 'Customer Login',
              backgroundColor: const Color(0xFF3A5EB5), // Bluish
              onPressed: () {
                Navigator.pushReplacement( // Use pushReplacement to remove InitialPage from stack
                  context,
                  MaterialPageRoute(builder: (context) => const CustomerLoginPage()),
                );
              },
            ),
            const SizedBox(height: 60),

            // Sign Up and Forgot Password Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 30), 
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent login option buttons
  Widget _buildLoginOptionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.white38, width: 1), // Subtle border
        ),
        elevation: 8,
        minimumSize: const Size(280, 60), // Fixed size for consistency
      ),
      icon: Icon(icon, size: 30),
      label: Text(
        label,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}