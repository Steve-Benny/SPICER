// lib/view_investments_page.dart

import 'package:flutter/material.dart';

// Model class to represent an investment/upfront capital deposit
class Investment {
  final String transactionId;
  final String investorName;
  final String investorType; // e.g., 'Consumer', 'Retailer', 'Business'
  final double amount;
  final String spiceBatchId; // Links to a specific listed spice batch
  final DateTime dateReceived;
  final bool isRefundable;

  Investment({
    required this.transactionId,
    required this.investorName,
    required this.investorType,
    required this.amount,
    required this.spiceBatchId,
    required this.dateReceived,
    this.isRefundable = false, // True if pre-purchase deposit, false if direct investment
  });
}

class ViewInvestmentsPage extends StatelessWidget {
  ViewInvestmentsPage({super.key});

  // Mock data for investments
  final List<Investment> _investments = [
    Investment(
      transactionId: 'INV001',
      investorName: 'Alex Johnson (Consumer)',
      investorType: 'Consumer',
      amount: 5000.00,
      spiceBatchId: 'SPCBCH-004',
      dateReceived: DateTime.parse('2025-09-20'),
      isRefundable: true, // Pre-purchase deposit
    ),
    Investment(
      transactionId: 'INV002',
      investorName: 'Kerala Spices Co. (Business)',
      investorType: 'Business',
      amount: 25000.00,
      spiceBatchId: 'SPCBCH-002',
      dateReceived: DateTime.parse('2025-08-15'),
      isRefundable: false, // Direct investment/loan
    ),
    Investment(
      transactionId: 'INV003',
      investorName: 'Retail Chain Z',
      investorType: 'Retailer',
      amount: 15000.00,
      spiceBatchId: 'SPCBCH-004',
      dateReceived: DateTime.parse('2025-08-15'),
      isRefundable: true,
    ),
  ];

  double get _totalInvestments => _investments.fold(
      0.0, (sum, item) => sum + item.amount);
      
        BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Investments'),
        backgroundColor: Colors.blueAccent, // Distinct color for Investments
        elevation: 0,
      ),
      body: Column(
        children: [
          // Total Investment Header Card
          _buildTotalInvestmentHeader(),
          
          // Investment List Title
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_investments.length} Records',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          
          // Investment List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: _investments.length,
              itemBuilder: (context, index) {
                return _buildInvestmentCard(_investments[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildTotalInvestmentHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent.shade700,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Upfront Capital Received',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            '₹${_totalInvestments.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '*Includes pre-purchase deposits and direct investments.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentCard(Investment investment) {
    final Color typeColor = investment.isRefundable ? Colors.orange : Colors.green;
    final String typeLabel = investment.isRefundable ? 'Pre-Purchase Deposit' : 'Direct Investment';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListTile(
        leading: Icon(
          investment.isRefundable ? Icons.shopping_bag : Icons.attach_money,
          color: typeColor,
          size: 36,
        ),
        title: Text(
          '₹${investment.amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${investment.investorName}'),
            Text('Batch ID: ${investment.spiceBatchId}'),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                typeLabel,
                style: TextStyle(color: typeColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              investment.dateReceived.toIso8601String().split('T')[0],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to Investment Detail page if necessary
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(content: Text('Viewing Transaction ${investment.transactionId}')),
          );
        },
      ),
    );
  }
}