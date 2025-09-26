// lib/initial_page.dart

import 'package:flutter/material.dart';
import 'package:spicer/login/login_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove backgroundColor from Scaffold as the image will cover it
      body: Stack(
        children: <Widget>[
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assests/images/home_background.png', // Your image path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          // Optional: Add a subtle overlay to make text more readable
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4), // Adjust opacity as needed
            ),
          ),

          // 2. Existing Content (Logo, Tagline, Button)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Spicer Logo (Text based, you'd replace with an image asset later)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.grass, color: Colors.white, size: 40),
                    const SizedBox(width: 8),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.white, Colors.lightGreenAccent],
                      ).createShader(bounds),
                      child: const Text(
                        'SPICER',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.qr_code_2_sharp, color: Colors.white, size: 28),
                  ],
                ),
                const SizedBox(height: 10),

                // Tagline
                const Text(
                  'Kerala\'s Spices, Verified by Blockchain',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 80), // Space before the button

                // Get Started Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.7), // Make button slightly transparent
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xFFFFD700), width: 2),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}