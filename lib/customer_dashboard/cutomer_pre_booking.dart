// lib/pre_booking_customer_page.dart

import 'package:flutter/material.dart';

class PreBookingCrop {
  final String farmerName;
  final String spiceName;
  final String location;
  final double fundingGoal;
  final double currentFunding;
  final DateTime expectedHarvestDate;

  const PreBookingCrop({
    required this.farmerName,
    required this.spiceName,
    required this.location,
    required this.fundingGoal,
    required this.currentFunding,
    required this.expectedHarvestDate,
  });
  
  double get fundingProgress => (currentFunding / fundingGoal).clamp(0.0, 1.0);
}

class PreBookingCustomerPage extends StatelessWidget {
  // FIX 1: Added 'const' back to the constructor
  PreBookingCustomerPage({super.key});

  final List<PreBookingCrop> _crops =[
    PreBookingCrop( // Added const
      farmerName: 'Anil Kumar (Idukki)',
      spiceName: 'Organic Vanilla Beans',
      location: 'Idukki, Kerala',
      fundingGoal: 50000.0,
      currentFunding: 35000.0,
      expectedHarvestDate: DateTime.parse('2026-03-01'),
    ),
    PreBookingCrop( // Added const
      farmerName: 'Shanti Growers',
      spiceName: 'Fresh Turmeric Root',
      location: 'Alappuzha',
      fundingGoal: 20000.0,
      currentFunding: 18000.0,
      // FIX 2: Used DateTime.parse()
      expectedHarvestDate: DateTime.parse('2025-12-15'),
    ),
    PreBookingCrop( // Added const
      farmerName: 'Sunil Farms',
      spiceName: 'High-Grade Cloves',
      location: 'Wayanad',
      fundingGoal: 40000.0,
      currentFunding: 10000.0,
      // FIX 3: Used DateTime.parse()
      expectedHarvestDate: DateTime.parse('2026-05-01'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-Book Crops'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _crops.length,
        itemBuilder: (context, index) {
          return _buildCropCard(_crops[index], context);
        },
      ),
    );
  }

  Widget _buildCropCard(PreBookingCrop crop, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              crop.spiceName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
            const SizedBox(height: 5),
            Text(
              'Farmer: ${crop.farmerName}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            _buildDetailRow(Icons.location_on, crop.location),
            // FIX: Using the parsed DateTime object in the display string
            _buildDetailRow(Icons.calendar_today, 'Harvest: ${crop.expectedHarvestDate.toString().split(' ')[0]}'),
            
            const SizedBox(height: 10),
            
            // Funding Progress Bar
            LinearProgressIndicator(
              value: crop.fundingProgress,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            const SizedBox(height: 5),
            Text(
              '${(crop.fundingProgress * 100).toStringAsFixed(0)}% Funded (₹${crop.currentFunding.toStringAsFixed(0)} of ₹${crop.fundingGoal.toStringAsFixed(0)})',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),
            
            // Pre-Book Button
            ElevatedButton.icon(
              onPressed: () {
                // F2b: Commit to Pre-Booking
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Committing to Pre-Booking ${crop.spiceName}')),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text('Commit to Pre-Book'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}