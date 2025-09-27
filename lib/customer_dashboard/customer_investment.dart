// lib/investment_opportunities_page.dart

import 'package:flutter/material.dart';

class InvestmentOpportunity {
  final String projectTitle;
  final String farmerName;
  final String location;
  final double returnEstimate; // Annual return percentage
  final double fundingNeeded;
  final double fundedAmount;

  const InvestmentOpportunity({
    required this.projectTitle,
    required this.farmerName,
    required this.location,
    required this.returnEstimate,
    required this.fundingNeeded,
    required this.fundedAmount,
  });
  
  double get fundingProgress => (fundedAmount / fundingNeeded).clamp(0.0, 1.0);
}

class InvestmentOpportunitiesPage extends StatelessWidget {
  const InvestmentOpportunitiesPage({super.key});

  final List<InvestmentOpportunity> _opportunities = const [
    InvestmentOpportunity(
      projectTitle: 'Solar Irrigation for Pepper',
      farmerName: 'Vikas Estates',
      location: 'Kottayam',
      returnEstimate: 12.0,
      fundingNeeded: 100000.0,
      fundedAmount: 75000.0,
    ),
    InvestmentOpportunity(
      projectTitle: 'Warehouse Expansion',
      farmerName: 'Global Exporters Inc.',
      location: 'Cochin Port',
      returnEstimate: 15.0,
      fundingNeeded: 250000.0,
      fundedAmount: 15000.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Opportunities'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _opportunities.length,
        itemBuilder: (context, index) {
          return _buildInvestmentCard(_opportunities[index], context);
        },
      ),
    );
  }

  Widget _buildInvestmentCard(InvestmentOpportunity opportunity, BuildContext context) {
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
              opportunity.projectTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            _buildDetailRow(Icons.person, 'Farmer/Business:', opportunity.farmerName),
            _buildDetailRow(Icons.location_on, 'Location:', opportunity.location),
            
            const Divider(height: 15),
            
            // Key Metric and Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric(
                  label: 'Return Est.',
                  value: '${opportunity.returnEstimate.toStringAsFixed(1)}%',
                  color: Colors.teal,
                ),
                _buildMetric(
                  label: 'Goal',
                  value: '₹${opportunity.fundingNeeded.toStringAsFixed(0)}',
                  color: Colors.blue,
                ),
                _buildMetric(
                  label: 'Funded',
                  value: '₹${opportunity.fundedAmount.toStringAsFixed(0)}',
                  color: Colors.green,
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: opportunity.fundingProgress,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 15),
            
            // Invest Button
            ElevatedButton.icon(
              onPressed: () {
                // F3b: Invest & Track Progress
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Investing in ${opportunity.projectTitle}')),
                );
              },
              icon: const Icon(Icons.savings),
              label: const Text('Invest Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text('$label $value'),
        ],
      ),
    );
  }
  
  Widget _buildMetric({required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}