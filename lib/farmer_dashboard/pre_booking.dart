// lib/pre_bookings_page.dart

import 'package:flutter/material.dart';

// Model class to represent a single pre-booking
class PreBooking {
  final String bookingId;
  final String spiceName;
  final String buyerName;
  final String buyerId;
  final double quantityKg;
  final double pricePerKg;
  final DateTime deliveryDate;
  BookingStatus status;

  PreBooking({
    required this.bookingId,
    required this.spiceName,
    required this.buyerName,
    required this.buyerId,
    required this.quantityKg,
    required this.pricePerKg,
    required this.deliveryDate,
    this.status = BookingStatus.pending,
  });

  // Calculate total value
  double get totalValue => quantityKg * pricePerKg;
}

enum BookingStatus {
  pending,
  accepted,
  fulfilled,
  rejected,
}

class PreBookingsPage extends StatefulWidget {
  const PreBookingsPage({super.key});

  @override
  State<PreBookingsPage> createState() => _PreBookingsPageState();
}

class _PreBookingsPageState extends State<PreBookingsPage> {
  // Mock data for pre-bookings
  final List<PreBooking> _bookings = [
    PreBooking(
      bookingId: 'PB001',
      spiceName: 'Organic Cardamom',
      buyerName: 'Priya Sharma (Retailer)',
      buyerId: 'C101',
      quantityKg: 50.0,
      pricePerKg: 1500.0,
      deliveryDate: DateTime.now().add(const Duration(days: 45)),
    ),
    PreBooking(
      bookingId: 'PB002',
      spiceName: 'Grade A Black Pepper',
      buyerName: 'Global Exporters Inc.',
      buyerId: 'B205',
      quantityKg: 200.0,
      pricePerKg: 650.0,
      deliveryDate: DateTime.now().add(const Duration(days: 90)),
      status: BookingStatus.accepted,
    ),
    PreBooking(
      bookingId: 'PB003',
      spiceName: 'Premium Turmeric Powder',
      buyerName: 'Rohan V.',
      buyerId: 'C102',
      quantityKg: 5.0,
      pricePerKg: 250.0,
      deliveryDate: DateTime.now().subtract(const Duration(days: 5)),
      status: BookingStatus.fulfilled,
    ),
  ];

  // Function to update the status of a booking
  void _updateBookingStatus(PreBooking booking, BookingStatus newStatus) {
    setState(() {
      booking.status = newStatus;
    });
    // In a real app, this is where you would call your Hyperledger Fabric API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking ${booking.bookingId} status updated to ${newStatus.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Pre-Bookings'),
        backgroundColor: Colors.orange, // Distinct color for Pre-Bookings
        elevation: 0,
      ),
      body: _bookings.isEmpty
          ? const Center(
              child: Text('No active pre-bookings right now.', style: TextStyle(fontSize: 18, color: Colors.grey)),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: _bookings.map((booking) => _buildBookingCard(booking)).toList(),
            ),
    );
  }

  // Helper method to determine the color for the status badge
  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Colors.blue;
      case BookingStatus.accepted:
        return Colors.green;
      case BookingStatus.fulfilled:
        return Colors.green.shade800;
      case BookingStatus.rejected:
        return Colors.red;
    }
  }

  // Builder for an individual booking card
  Widget _buildBookingCard(PreBooking booking) {
    final statusColor = _getStatusColor(booking.status);
    final isPending = booking.status == BookingStatus.pending;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Spice Name and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    booking.spiceName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 15, color: Colors.grey),

            // Buyer and Quantity Details
            _buildDetailRow(Icons.person, 'Buyer:', booking.buyerName),
            _buildDetailRow(Icons.warehouse, 'Quantity:', '${booking.quantityKg.toStringAsFixed(1)} kg'),
            _buildDetailRow(Icons.monetization_on, 'Total Value:', '₹${booking.totalValue.toStringAsFixed(2)}'),
            _buildDetailRow(
              Icons.calendar_month,
              'Due Date:',
              '${booking.deliveryDate.day}/${booking.deliveryDate.month}/${booking.deliveryDate.year}',
            ),

            // Action Buttons (Visible only for Pending bookings)
            if (isPending) ...[
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _updateBookingStatus(booking, BookingStatus.accepted),
                      icon: const Icon(Icons.check),
                      label: const Text('Accept'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _updateBookingStatus(booking, BookingStatus.rejected),
                      icon: const Icon(Icons.close),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (booking.status == BookingStatus.accepted) ...[
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => _updateBookingStatus(booking, BookingStatus.fulfilled),
                icon: const Icon(Icons.delivery_dining),
                label: const Text('Mark as Fulfilled'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper method for consistent detail rows
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 4),
          Text(value),
        ],
      ),
    );
  }
}