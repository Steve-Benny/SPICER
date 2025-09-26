// lib/traceability_page.dart

import 'package:flutter/material.dart';

// --- Data Models ---

class TraceEvent {
  final String title;
  final String location;
  final DateTime timestamp;
  final String details;
  final IconData icon;
  final Color color;

  TraceEvent({
    required this.title,
    required this.location,
    required this.timestamp,
    required this.details,
    required this.icon,
    required this.color,
  });
}

class SpiceBatch {
  final String batchId;
  final String spiceName;
  final List<TraceEvent> events;

  SpiceBatch({
    required this.batchId,
    required this.spiceName,
    required this.events,
  });
}

// --- Traceability Page Widget ---

class TraceabilityPage extends StatefulWidget {
  const TraceabilityPage({super.key});

  @override
  State<TraceabilityPage> createState() => _TraceabilityPageState();
}

class _TraceabilityPageState extends State<TraceabilityPage> {
  // Mock data for the trace events of a single spice batch
  final SpiceBatch _mockBatch = SpiceBatch(
    batchId: 'SPCBCH-004',
    spiceName: 'Organic Black Pepper (Grade A)',
    events: [
      TraceEvent(
        title: 'Cultivation & Registration',
        location: 'Idukki Farm (Farmer: [Farmer Name])',
        timestamp: DateTime.parse('2025-01-10T09:00:00'),
        details: 'Batch registered on Hyperledger Fabric. Initial quality check: Certified Organic.',
        icon: Icons.grass,
        color: Colors.green,
      ),
      TraceEvent(
        title: 'Harvesting Complete',
        location: 'Idukki Farm',
        timestamp: DateTime.parse('2025-09-01T15:30:00'),
        details: '300 kg harvested. Data hash written to blockchain. QR Code assigned.',
        icon: Icons.event_available,
        color: Colors.lightGreen,
      ),
      TraceEvent(
        title: 'Quality Assurance & Sorting',
        location: 'Processing Unit, Kochi',
        timestamp: DateTime.parse('2025-09-05T10:45:00'),
        details: 'AI/ML anti-fraud check passed. Moisture content logged. Batch split for export.',
        icon: Icons.security,
        color: Colors.blueAccent,
      ),
      TraceEvent(
        title: 'Export Documentation',
        location: 'Cochin Port',
        timestamp: DateTime.parse('2025-09-10T14:00:00'),
        details: 'Exim documentation attached. Bill of Lading (BOL) hash stored on-chain.',
        icon: Icons.local_shipping,
        color: Colors.blueGrey,
      ),
      TraceEvent(
        title: 'Consumer Pre-purchase',
        location: 'Online Platform',
        timestamp: DateTime.parse('2025-09-20T11:00:00'),
        details: 'Upfront capital received from Retail Chain Z. Record linked to Batch ID.',
        icon: Icons.attach_money,
        color: Colors.orange,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traceability Ledger'),
        backgroundColor: Colors.teal, // Distinct color for traceability
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Summary
          _buildHeaderSummary(),

          // Timeline View
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 20.0, bottom: 10.0),
            child: Text(
              'Batch Journey (Blockchain Timeline)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: _mockBatch.events.length,
              itemBuilder: (context, index) {
                final event = _mockBatch.events[index];
                final isLast = index == _mockBatch.events.length - 1;
                return _buildTimelineItem(event, isLast);
              },
            ),
          ),
          
          // QR Scan Button (for farmers to log new steps)
          _buildQRScanButton(),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeaderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.teal.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tracing:',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            _mockBatch.spiceName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.qr_code_2, size: 18, color: Colors.teal),
              const SizedBox(width: 8),
              Text(
                'Batch ID: ${_mockBatch.batchId}',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(TraceEvent event, bool isLast) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Timeline Indicator
          Column(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: event.color,
                ),
                child: Icon(event.icon, color: Colors.white, size: 24),
              ),
              // Connector Line (hidden for the last item)
              if (!isLast)
                Container(
                  width: 2.0,
                  height: 60.0,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
          const SizedBox(width: 15.0),
          // Event Details Card
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  event.location,
                  style: TextStyle(color: event.color, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                Text(
                  event.details,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Text(
                  '${event.timestamp.day}/${event.timestamp.month}/${event.timestamp.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQRScanButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement actual camera QR scanning logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Opening Camera for New Event Log...')),
          );
        },
        icon: const Icon(Icons.add_circle, size: 28),
        label: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Log New Batch Step', style: TextStyle(fontSize: 18)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}