// lib/customer_dashboard_page.dart

import 'package:flutter/material.dart';

// --- Placeholder Page Imports ---
// NOTE: We'll need to create these destination pages later!
class MarketplacePage extends StatelessWidget { const MarketplacePage({super.key}); @override Widget build(BuildContext context) => const Placeholder(child: Center(child: Text('Marketplace Page')));}
class PreBookingCustomerPage extends StatelessWidget { const PreBookingCustomerPage({super.key}); @override Widget build(BuildContext context) => const Placeholder(child: Center(child: Text('Pre-Bookings Page')));}
class InvestmentOpportunitiesPage extends StatelessWidget { const InvestmentOpportunitiesPage({super.key}); @override Widget build(BuildContext context) => const Placeholder(child: Center(child: Text('Investment Opportunities Page')));}
class CustomerTraceabilityPage extends StatelessWidget { const CustomerTraceabilityPage({super.key}); @override Widget build(BuildContext context) => const Placeholder(child: Center(child: Text('Customer Traceability Page')));}
class ReviewsPage extends StatelessWidget { const ReviewsPage({super.key}); @override Widget build(BuildContext context) => const Placeholder(child: Center(child: Text('Reviews & Ratings Page')));}
class CustomerProfilePage extends StatelessWidget { const CustomerProfilePage({super.key}); @override Widget build(BuildContext context) => const Placeholder(child: Center(child: Text('Customer Profile Page')));}


class CustomerDashboardPage extends StatelessWidget {
  const CustomerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF3A5EB5), // Customer Blue color
        actions: [
          // Shopping Cart Icon
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Cart')),
              );
            },
            tooltip: 'Cart',
          ),
          // Profile Icon
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CustomerProfilePage()),
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
            // Welcome Section
            const Text(
              'Welcome, Customer Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF3A5EB5)),
            ),
            const SizedBox(height: 5),
            const Text(
              'Explore authentic spices, pre-book crops, and invest in sustainable farming.',
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
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                // F1: Buy Spices (Marketplace)
                _buildDashboardCard(
                  context,
                  icon: Icons.storefront,
                  title: 'Buy Spices',
                  subtitle: 'Browse fresh, verified, and traceable spices.',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MarketplacePage()));
                  },
                  color: Colors.lightGreen,
                ),

                // F2: Pre-Book Crops
                _buildDashboardCard(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Pre-Book Crops',
                  subtitle: 'Fund a harvest and secure your supply.',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PreBookingCustomerPage()));
                  },
                  color: Colors.orange,
                ),

                // F3: Invest in Farms
                _buildDashboardCard(
                  context,
                  icon: Icons.attach_money,
                  title: 'Invest in Farms',
                  subtitle: 'View opportunities and track farm progress.',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InvestmentOpportunitiesPage()));
                  },
                  color: Colors.green,
                ),

                // F4: Traceability & QR Scan
                _buildDashboardCard(
                  context,
                  icon: Icons.qr_code_scanner,
                  title: 'Trace & Verify',
                  subtitle: 'Scan any QR code to see its full journey.',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerTraceabilityPage()));
                  },
                  color: Colors.teal,
                ),

                // F5: Reviews & Ratings
                _buildDashboardCard(
                  context,
                  icon: Icons.star_rate,
                  title: 'Reviews & Ratings',
                  subtitle: 'Rate farmers and spice quality.',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewsPage()));
                  },
                  color: Colors.redAccent,
                ),

                // F6 (Added Extra): Track Orders
                _buildDashboardCard(
                  context,
                  icon: Icons.delivery_dining,
                  title: 'Track Orders',
                  subtitle: 'View your purchase and pre-booking status.',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigate to Order History')),
                    );
                  },
                  color: Colors.blueAccent,
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
          label: 'Spices Purchased',
          value: '45 kg',
          icon: Icons.shopping_bag,
          color: Colors.blue,
        ),
        _MetricCard(
          label: 'Active Investments',
          value: '3',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        _MetricCard(
          label: 'Total Orders',
          value: '12',
          icon: Icons.local_shipping,
          color: Colors.purple,
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

// Separate Widget for Metrics (Reused from Farmer Dashboard)
class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap; // Kept optional for future click functionality

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
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