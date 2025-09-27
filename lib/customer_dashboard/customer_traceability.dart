// lib/customer_traceability_page.dart

import 'package:flutter/material.dart';

class CustomerTraceabilityPage extends StatelessWidget {
  const CustomerTraceabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trace & Verify'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.qr_code_scanner, size: 100, color: Colors.teal),
              const SizedBox(height: 20),
              const Text(
                'Verify the Spice Journey',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Scan the QR code on your spice packaging to view its verified, immutable history on the blockchain.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // F4a: Scan QR Code Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement camera QR scanning logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening Camera for QR Scan... (F4a)')),
                  );
                },
                icon: const Icon(Icons.camera_alt, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Scan QR Code', style: TextStyle(fontSize: 20)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              
              // Input Field for Manual Batch ID (Alternative to F4a)
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Batch ID Manually',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // F4b: View Spice Journey (Placeholder logic)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing Spice Journey for Manual ID... (F4b)')),
                  );
                },
                child: const Text('Trace Batch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}