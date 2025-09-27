// lib/customer_profile_page.dart

import 'package:flutter/material.dart';

class CustomerProfile {
  final String name;
  final String email;
  final String location;
  final double totalSpent;
  final int activeInvestments;

  const CustomerProfile({
    this.name = 'Priya Sharma',
    this.email = 'priya.sharma@mail.com',
    this.location = 'Kochi, Kerala',
    this.totalSpent = 32500.00,
    this.activeInvestments = 2,
  });
}

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});
  
  final CustomerProfile profile = const CustomerProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF3A5EB5),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Edit Profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Profile Header
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(profile.location, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 30),

            // Contact Details
            _buildDetailTile(Icons.mail, 'Email', profile.email),
            _buildDetailTile(Icons.location_on, 'Location', profile.location),
            
            const Divider(height: 30),

            // Financial Metrics
            _buildMetricCard(
              context,
              title: 'Total Spent on Spices',
              value: '₹${profile.totalSpent.toStringAsFixed(2)}',
              icon: Icons.money,
              color: Colors.green,
            ),
            _buildMetricCard(
              context,
              title: 'Active Investments',
              value: '${profile.activeInvestments}',
              icon: Icons.trending_up,
              color: Colors.purple,
            ),

            const SizedBox(height: 30),
            // Settings/Logout
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Account Settings'),
              onTap: () { /* TODO */ },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: () { /* TODO: Implement Logout */ },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(value),
    );
  }

  Widget _buildMetricCard(BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }
}