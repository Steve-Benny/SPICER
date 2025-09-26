// lib/farmer_listings_page.dart

import 'package:flutter/material.dart';

// --- Data Model for an active listing ---
class SpiceListing {
  final String batchId;
  final String productName;
  final String spiceType;
  final double quantityKg;
  final double pricePerKg;
  final DateTime plantedDate;
  final String status; // e.g., 'Active', 'Sold Out', 'Pending Approval'
  final String imageUrl;

  SpiceListing({
    required this.batchId,
    required this.productName,
    required this.spiceType,
    required this.quantityKg,
    required this.pricePerKg,
    required this.plantedDate,
    this.status = 'Active',
    this.imageUrl = 'https://via.placeholder.com/150', // Placeholder image
  });

  double get totalValue => quantityKg * pricePerKg;
}

// --- Farmer Listings Page Widget ---
class FarmerListingsPage extends StatelessWidget {
  FarmerListingsPage({super.key});

  // Mock data for the 4 total listings (matching the dashboard metric)
  final List<SpiceListing> _listings = [
    SpiceListing(
      batchId: 'SPCBCH-004',
      productName: 'Organic Black Pepper - Grade A',
      spiceType: 'Black Pepper',
      quantityKg: 300.0,
      pricePerKg: 650.0,
      plantedDate: DateTime.utc(2025, 1, 10),
      status: 'Active',
    ),
    SpiceListing(
      batchId: 'SPCBCH-005',
      productName: 'Idukki Cardamom - Premium',
      spiceType: 'Cardamom',
      quantityKg: 50.0,
      pricePerKg: 1550.0,
      plantedDate:  DateTime.utc(2024, 11, 20),
      status: 'Active',
    ),
    SpiceListing(
      batchId: 'SPCBCH-006',
      productName: 'Fresh Turmeric Root',
      spiceType: 'Turmeric',
      quantityKg: 150.0,
      pricePerKg: 180.0,
      plantedDate: DateTime.utc(2025, 3, 5),
      status: 'Sold Out',
    ),
    SpiceListing(
      batchId: 'SPCBCH-007',
      productName: 'Nutmeg with Shell',
      spiceType: 'Nutmeg',
      quantityKg: 80.0,
      pricePerKg: 800.0,
      plantedDate: DateTime.utc(2024, 12, 1),
      status: 'Active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Active Listings'),
        backgroundColor: Colors.blue, // Matching the metric card color
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              // TODO: Navigate to SellSpicesPage
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Go to List a New Spice')),
              );
            },
            tooltip: 'List New Spice',
          ),
        ],
      ),
      body: _listings.isEmpty
          ? const Center(
              child: Text(
                'You have no active listings. List a new spice now!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _listings.length,
              itemBuilder: (context, index) {
                return _buildListingCard(_listings[index], context);
              },
            ),
    );
  }

  // --- Widget Builders ---

  Widget _buildListingCard(SpiceListing listing, BuildContext context) {
    final statusColor = listing.status == 'Active' ? Colors.green : Colors.red;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Name, Batch ID, and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    listing.productName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    listing.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Batch ID: ${listing.batchId} | Type: ${listing.spiceType}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const Divider(height: 20),

            // Details Grid
            _buildDetailsGrid(listing),

            const Divider(height: 20),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to Edit Listing Page
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Edit ${listing.productName}')),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to Traceability Page for this Batch ID
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Trace Batch ${listing.batchId}')),
                    );
                  },
                  icon: const Icon(Icons.qr_code_2, size: 18),
                  label: const Text('Trace'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper for displaying key numerical metrics
  Widget _buildDetailsGrid(SpiceListing listing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailColumn(
          label: 'Quantity (kg)',
          value: listing.quantityKg.toStringAsFixed(1),
          color: Colors.teal,
        ),
        _buildDetailColumn(
          label: 'Price (₹/kg)',
          value: listing.pricePerKg.toStringAsFixed(2),
          color: Colors.indigo,
        ),
        _buildDetailColumn(
          label: 'Total Value (₹)',
          value: listing.totalValue.toStringAsFixed(0),
          color: Colors.green,
        ),
      ],
    );
  }
  
  // Helper for consistent detail columns
  Widget _buildDetailColumn({required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}