// lib/login/farmer_sign_up_page.dart

import 'package:flutter/material.dart';
import 'package:spicer/customer_dashboard/customer_dashboard.dart';
import 'package:spicer/login/customer_login_page.dart';

class CustomerSignUpPage extends StatefulWidget {
  const CustomerSignUpPage({super.key});

  @override
  State<CustomerSignUpPage> createState() => _CustomerSignUpPageState();
}

class _CustomerSignUpPageState extends State<CustomerSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  bool _acceptTerms = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      // 1. Collect Data
      
      // 2. TODO: Implement Firebase Auth createUserWithEmailAndPassword() here
      // 3. TODO: Write farmer profile data to Firestore/Database

      // Show success and navigate
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer account created successfully!')),
      );

      // Navigate to Dashboard after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerDashboardPage()),
      );
    } else if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must accept the terms and conditions.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E4620), // Dark green background
      appBar: AppBar(
        title: const Text('Customer Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement( // Use pushReplacement to remove InitialPage from stack
                  context,
                  MaterialPageRoute(builder: (context) => const CustomerLoginPage()));
                  },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.grass, color: Color(0xFFB57F3A), size: 80),
                const SizedBox(height: 10),
                const Text(
                  'Register Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),

                // 1. Name Field
                _buildTextFormField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  icon: Icons.person,
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 20),

                // 2. Email Field
                _buildTextFormField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 20),
                
                // 3. Password Field
                _buildPasswordField(),
                const SizedBox(height: 20),
                
                // 4. Phone Number Field
                _buildTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.length < 10 ? 'Enter a 10-digit phone number' : null,
                ),
                const SizedBox(height: 20),
                
                // 5. Terms & Conditions Checkbox
                _buildTermsCheckbox(),
                const SizedBox(height: 30),

                // 6. Sign Up Button
                ElevatedButton(
                  onPressed: (){
                     Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CustomerDashboardPage()),
            );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB57F3A), // Brownish-orange
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Sign Up ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                
                // Already have an account? Login link
                TextButton(onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CustomerDashboardPage()),
            );
        } ,
                  child: const Text('Already have an account? Log In', style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Reusable Widget Builders ---

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration.copyWith(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration.copyWith(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (bool? newValue) {
            setState(() {
              _acceptTerms = newValue!;
            });
          },
          activeColor: Colors.white,
          checkColor: const Color(0xFFB57F3A),
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              text: 'I agree to the ',
              style: const TextStyle(color: Colors.white70),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  // onTap logic to show terms
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Consistent input decoration for all fields
  static const InputDecoration _inputDecoration = InputDecoration(
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
}