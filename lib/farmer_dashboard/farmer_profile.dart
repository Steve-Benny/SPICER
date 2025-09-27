// lib/farmer_profile_page.dart

import 'package:flutter/material.dart';

// --- Mock Data Models (reused from previous pages) ---

// Mock Farmer Data (based on sign-up fields)
class FarmerProfile {
  final String name;
  final String farmName;
  final String location;
  final String email;
  final String phoneNumber;
  final String bio;
  final double rating;
  final int totalListings;
  final double totalInvestments;

  const FarmerProfile({
    this.name = 'Anil Kumar',
    this.farmName = 'Green Hills Organics',
    this.location = 'Idukki, Kerala',
    this.email = 'anil.kumar@greenhills.com',
    this.phoneNumber = '+91 98765 43210',
    this.bio = 'Third-generation organic spice farmer specializing in high-grade Cardamom and Black Pepper. Committed to sustainable practices and transparency via Spicer.',
    this.rating = 4.8,
    this.totalListings = 4, // Matches the dashboard metric
    this.totalInvestments = 45000.00, // Matches total from ViewInvestmentsPage mock data
  });
}

// Mock Listing Data (simplified)
class ListingSummary {
  final String spiceType;
  final double quantityKg;
  final String batchId;

  const ListingSummary({
    required this.spiceType,
    required this.quantityKg,
    required this.batchId,
  });
}


class FarmerProfilePage extends StatelessWidget {
  final FarmerProfile farmer = const FarmerProfile();
  
  // Mock listing data specific to the profile view
  final List<ListingSummary> _activeCrops = const [
    ListingSummary(spiceType: 'Cardamom (Premium)', quantityKg: 50.0, batchId: 'BCH-005'),
    ListingSummary(spiceType: 'Black Pepper (Grade A)', quantityKg: 300.0, batchId: 'BCH-004'),
    ListingSummary(spiceType: 'Nutmeg', quantityKg: 80.0, batchId: 'BCH-007'),
  ];

  const FarmerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farmer Profile'),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to Edit Profile Page
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to Edit Profile')),
              );
            },
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // --- 1. Profile Header and Stats ---
            _buildProfileHeader(context),
            
            // --- 2. Bio/Description ---
            _buildBioSection(context),

            // --- 3. Investment Summary Card ---
            _buildInvestmentSummaryCard(context),

            // --- 4. Active Crops Listed ---
            _buildCropListSection(context),
          ],
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 60, color: Colors.green),
          ),
          const SizedBox(height: 10),
          Text(
            farmer.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            farmer.farmName,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                farmer.location,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text(
                '${farmer.rating} / 5.0 (Trusted Producer)',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Farmer Bio & Credentials',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 10, color: Colors.green),
          Text(
            farmer.bio,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 15),
          _buildDetailRow(Icons.mail, farmer.email),
          _buildDetailRow(Icons.phone, farmer.phoneNumber),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.green.shade600),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildInvestmentSummaryCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Card(
        color: Colors.amber.shade50,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upfront Capital Received (Total)',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${farmer.totalInvestments.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade800,
                    ),
                  ),
                  const Icon(Icons.account_balance_wallet, size: 40, color: Colors.amber),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Funding from ${farmer.totalListings} active projects.',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCropListSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Crops Listed',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 10, color: Colors.green),
          
          if (_activeCrops.isEmpty)
            const Text('No crops currently listed for sale.', style: TextStyle(color: Colors.grey)),
            
          ..._activeCrops.map((crop) => _buildCropListingTile(crop)).toList(),
          
          const SizedBox(height: 10),
          Center(
            child: TextButton.icon(
              onPressed: () {
                // TODO: Navigate to FarmerListingsPage (The full list)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('View Full Listings')),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View All Listings'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCropListingTile(ListingSummary crop) {
    return ListTile(
      leading: const Icon(Icons.local_florist, color: Colors.lightGreen),
      title: Text(crop.spiceType, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text('Batch: ${crop.batchId}'),
      trailing: Text('${crop.quantityKg.toStringAsFixed(0)} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
      contentPadding: EdgeInsets.zero,
    );
  }
}