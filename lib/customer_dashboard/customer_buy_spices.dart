// lib/marketplace_page.dart

import 'package:flutter/material.dart';

// --- Data Model for a Spice Product ---
class SpiceProduct {
  final String id;
  final String name;
  final String farmerName;
  final double pricePerKg;
  final double availableQuantityKg;
  final double rating;
  final String location;
  final bool isOrganic;
  final String imageUrl;

  const SpiceProduct({
    required this.id,
    required this.name,
    required this.farmerName,
    required this.pricePerKg,
    required this.availableQuantityKg,
    required this.rating,
    required this.location,
    this.isOrganic = false,
    this.imageUrl = 'https://via.placeholder.com/150', // Placeholder
  });
}

// --- Marketplace Page Widget ---
class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  // Mock data for the spice marketplace
  final List<SpiceProduct> _spices = const [
    SpiceProduct(
      id: 'P001',
      name: 'Idukki Cardamom',
      farmerName: 'Anil Kumar (Green Hills Organics)',
      pricePerKg: 1550.00,
      availableQuantityKg: 50.0,
      rating: 4.8,
      location: 'Idukki',
      isOrganic: true,
      imageUrl: 'https://via.placeholder.com/150/500045/FFFFFF?text=Cardamom',
    ),
    SpiceProduct(
      id: 'P002',
      name: 'Black Pepper (Grade A)',
      farmerName: 'Sunil Farms',
      pricePerKg: 680.00,
      availableQuantityKg: 300.0,
      rating: 4.5,
      location: 'Wayanad',
      isOrganic: false,
      imageUrl: 'https://via.placeholder.com/150/000000/FFFFFF?text=Pepper',
    ),
    SpiceProduct(
      id: 'P003',
      name: 'Premium Turmeric Powder',
      farmerName: 'Shanti Growers',
      pricePerKg: 220.00,
      availableQuantityKg: 120.0,
      rating: 4.9,
      location: 'Alappuzha',
      isOrganic: true,
      imageUrl: 'https://via.placeholder.com/150/FFC300/FFFFFF?text=Turmeric',
    ),
    SpiceProduct(
      id: 'P004',
      name: 'Whole Cloves',
      farmerName: 'Vikas Estates',
      pricePerKg: 850.00,
      availableQuantityKg: 80.0,
      rating: 4.2,
      location: 'Kottayam',
      isOrganic: false,
      imageUrl: 'https://via.placeholder.com/150/8B4513/FFFFFF?text=Cloves',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spices Marketplace'),
        backgroundColor: const Color(0xFF3A5EB5),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search activated')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: Navigate to Cart & Checkout (F1b)
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Go to Cart & Checkout')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with Filters/Info
          _buildFilterBar(),

          // Spice Listings
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _spices.length,
              itemBuilder: (context, index) {
                return _buildProductCard(_spices[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '4 Active Listings', // Matches mock data count
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          TextButton.icon(
            onPressed: () {
              // TODO: Open sort/filter modal
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Open Sort/Filter Options')),
              );
            },
            icon: const Icon(Icons.filter_list, size: 18),
            label: const Text('Filter & Sort'),
            style: TextButton.styleFrom(foregroundColor: Colors.black87),
          ),
        ],
      ),
    );
  }

  // In lib/marketplace_page.dart, replace the existing _buildProductCard function

  Widget _buildProductCard(SpiceProduct product, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image and Organic Badge (Fixed Width)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product.isOrganic)
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'ORGANIC',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 15),

            // 2. Product Details (MUST BE WRAPPED in Expanded)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name (Allow it to wrap if necessary)
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  
                  // FIX 1: Farmer Name and Location Row
                  Row(
                    children: [
                      Icon(Icons.person_pin_circle, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      // Use Flexible here to force the long text to fit the remaining space
                      Flexible( 
                        child: Text(
                          '${product.farmerName} (${product.location})',
                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                          overflow: TextOverflow.ellipsis, // Critical for long names
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating and Price Row
                  Row(
  children: [
    // Quantity text takes all the leftover space
    Expanded(
      child: Text(
        '${product.availableQuantityKg.toStringAsFixed(0)} kg available',
        style: TextStyle(
          fontSize: 12,
          color: Colors.green.shade700,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),

    const SizedBox(width: 8),

    // Button stays fixed size
    ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} added to cart!')),
        );
      },
      icon: const Icon(Icons.add_shopping_cart, size: 18),
      label: const Text('Add to Cart'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ],
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}