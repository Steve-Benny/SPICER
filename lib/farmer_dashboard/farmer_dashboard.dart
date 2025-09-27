// lib/farmer_dashboard_page.dart (CORRECTED)

import 'package:flutter/material.dart';
// Note: Ensure these imports match your new file structure and correct class names
import 'package:spicer/farmer_dashboard/communication.dart'; // Contains MessagingCenterPage
import 'package:spicer/farmer_dashboard/farmer_listings_page.dart';
import 'package:spicer/farmer_dashboard/investment.dart'; // Contains ViewInvestmentsPage
import 'package:spicer/farmer_dashboard/pre_booking.dart'; // Contains PreBookingsPage
import 'package:spicer/farmer_dashboard/farmer_profile.dart'; // Contains FarmerProfilePage
import 'package:spicer/farmer_dashboard/sell_spices.dart'; // Contains SellSpicesPage
import 'package:spicer/farmer_dashboard/tarceability.dart'; // Contains TraceabilityPage // Used by Total Listings Metric
// We need the actual class names to be accessible.

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
        
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // CORRECTED NAVIGATION: Just push the Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FarmerProfilePage()), // Corrected class name
              );
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
            // Welcome Section (Use InkWell to make it clickable to profile)
            InkWell(
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FarmerProfilePage()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Welcome, [Farmer Name]',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Manage your listings, investments, and community connections.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Key Metrics (Placeholder for quick stats)
            _buildKeyMetricsRow(context), // Pass context here for navigation
            const SizedBox(height: 30),

            // Main Dashboard Features Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                // E1: Sell Spices
                _buildDashboardCard(
                  context,
                  icon: Icons.store,
                  title: 'Add Spices',
                  subtitle: 'Register a spice you planted.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SellSpicesPage()), // Added const
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PreBookingsPage()), // Added const
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewInvestmentsPage()), // Added const
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TraceabilityPage()), // Added const
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MessagingCenterPage()), // Added const
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

  // Needs Context passed to enable MetricCard onTap navigation
  Widget _buildKeyMetricsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _MetricCard(
          label: 'Total Listings',
          value: '4',
          icon: Icons.list_alt,
          color: Colors.blue,
          onTap: () { // Navigation to Listings Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FarmerListingsPage()),
            );
          },
        ),
        _MetricCard(
          label: 'Pending Orders',
          value: '3',
          icon: Icons.pending_actions,
          color: Colors.orange,
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PreBookingsPage()),
            );
          },
        ),
        _MetricCard(
          label: 'Total Earned',
          value: '₹12,500',
          icon: Icons.currency_rupee,
          color: Colors.green,
          onTap: () {
            // Placeholder action
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Viewing Earnings History')),
            );
          },
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

// Separate Widget for Metrics (Modified to accept onTap)
class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // Added InkWell to make it clickable
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}