// lib/farmer_dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:spicer/farmer_dashboard/communication.dart';
import 'package:spicer/farmer_dashboard/investment.dart';
import 'package:spicer/farmer_dashboard/pre_booking.dart';
import 'package:spicer/farmer_dashboard/sell_spices.dart';
import 'package:spicer/farmer_dashboard/tarceability.dart';
import 'package:spicer/login/farmer_login_page.dart';

class FarmerDashboardPage extends StatelessWidget {
  const FarmerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmer Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement( // Use pushReplacement to remove InitialPage from stack
                  context,
                  MaterialPageRoute(builder: (context) => const FarmerLoginPage()));
                  },
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Implement Logout Logic
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile.')),
              );
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            tooltip: 'Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Welcome Section
            const Text(
              'Welcome, [Farmer Name]',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            const Text(
              'Manage your listings, investments, and community connections.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 25),

            // Key Metrics (Placeholder for quick stats)
            _buildKeyMetricsRow(),
            const SizedBox(height: 30),

            // Main Dashboard Features Grid
            GridView.count(
              crossAxisCount: 2, // Two cards per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Important for SingleChildScrollView
              children: <Widget>[
                // E1: Sell Spices
                _buildDashboardCard(
                  context,
                  icon: Icons.store,
                  title: 'Add Spices',
                  subtitle: 'Register a spice you planted.',
                  onTap: () {
                    // E1a & E1b: List a New Spice, Set Price & Quantity
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SellSpicesPage()),
                    );
                  },
                  color: Colors.lightGreen,
                ),

                // E2: Manage Pre-Bookings
                _buildDashboardCard(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Pre-Bookings',
                  subtitle: 'Review and fulfill pre-booked orders.',
                  onTap: () {
                 // Navigate to the new PreBookingsPage
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PreBookingsPage()),
                  );
                 },
                  color: Colors.orange,
                ),

                // E3: View Investments
                _buildDashboardCard(
                  context,
                  icon: Icons.account_balance_wallet,
                  title: 'View Investments',
                  subtitle: 'See upfront capital from consumers.',
                  onTap: () {
    // Navigate to the new ViewInvestmentsPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewInvestmentsPage()),
    );
  },
                  color: Colors.blueAccent,
                ),

                // E4: Traceability & QR Scan
                _buildDashboardCard(
                  context,
                  icon: Icons.qr_code_scanner,
                  title: 'Traceability',
                  subtitle: 'Scan and log batch movements.',
                  onTap: ()  {
                   // Navigate to the new ViewInvestmentsPage
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TraceabilityPage()),
                  );
                },
                  color: Colors.teal,
                ),

                // E5: Messaging Center
                _buildDashboardCard(
                  context,
                  icon: Icons.message,
                  title: 'Messaging Center',
                  subtitle: 'Communicate with buyers/investors.',
                  onTap: () {
                  // Navigate to the new ViewInvestmentsPage
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagingCenterPage()),
                );
                },
                  color: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Reusable Widget Builders ---

  Widget _buildKeyMetricsRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _MetricCard(
          label: 'Total Listings',
          value: '4',
          icon: Icons.list_alt,
          color: Colors.blue,
        ),
        _MetricCard(
          label: 'Pending Orders',
          value: '3',
          icon: Icons.pending_actions,
          color: Colors.orange,
        ),
        _MetricCard(
          label: 'Total Earned',
          value: '₹12,500',
          icon: Icons.currency_rupee,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildDashboardCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Separate Widget for Metrics
class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}