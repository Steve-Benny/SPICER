// lib/track_orders_page.dart

import 'package:flutter/material.dart';

class OrderItem {
  final String orderId;
  final String productName;
  final String status;
  final DateTime orderDate;
  final Color statusColor;

  const OrderItem({
    required this.orderId,
    required this.productName,
    required this.status,
    required this.orderDate,
    required this.statusColor,
  });
}

class TrackOrdersPage extends StatelessWidget {
  TrackOrdersPage({super.key});

  final List<OrderItem> _orders=[
    OrderItem(
      orderId: 'ORD-5542',
      productName: 'Idukki Cardamom (50kg)',
      status: 'Shipped',
      orderDate: DateTime.parse('2025-09-10'),
      statusColor: Colors.blue,
    ),
    OrderItem(
      orderId: 'PRE-901',
      productName: 'Organic Vanilla Beans (Pre-Book)',
      status: 'In Cultivation',
      orderDate: DateTime.parse('2025-08-01'),
      statusColor: Colors.orange,
    ),
    OrderItem(
      orderId: 'ORD-5541',
      productName: 'Black Pepper (5kg)',
      status: 'Delivered',
      orderDate: DateTime.parse('2025-09-01'),
      statusColor: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders & Pre-Bookings'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(_orders[index]);
        },
      ),
    );
  }

  Widget _buildOrderCard(OrderItem item) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.local_shipping, color: item.statusColor, size: 36),
        title: Text(
          item.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Order ID: ${item.orderId} | Date: ${item.orderDate.toString().split(' ')[0]}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: item.statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            item.status,
            style: TextStyle(color: item.statusColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        onTap: () {
          // TODO: Navigate to Order Details
        },
      ),
    );
  }
}