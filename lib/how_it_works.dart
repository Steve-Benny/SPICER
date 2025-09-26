// lib/how_it_works_page.dart

import 'package:flutter/material.dart';

class HowItWorksPage extends StatefulWidget {
  const HowItWorksPage({super.key});

  @override
  State<HowItWorksPage> createState() => _HowItWorksPageState();
}

class _HowItWorksPageState extends State<HowItWorksPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How It Works'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'A Simple Journey from Farm to Fork',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Our transparent system ensures every spice is authentic and ethically sourced.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Stepper(
                steps: _getSteps(),
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < _getSteps().length - 1) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        if (details.currentStep < _getSteps().length - 1)
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: const Text('NEXT'),
                          ),
                        const SizedBox(width: 10),
                        if (details.currentStep > 0)
                          TextButton(
                            onPressed: details.onStepCancel,
                            child: const Text('BACK'),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: const Text('1. Farmer Registration'),
        subtitle: const Text('Farmers register their harvest on the blockchain ledger.'),
        content: const Text(
            'Farmers input cultivation details, harvesting dates, and quality certifications. This data is the first, unchangeable record of the spice\'s journey.'),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('2. Unique QR Code Generation'),
        subtitle: const Text('A unique digital identity is created for each batch.'),
        content: const Text(
            'A cryptographic hash of the farmer\'s data is created, and a QR code is generated. This code is then attached to the spice packaging.'),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('3. Stakeholder Verification'),
        subtitle: const Text('Traders and exporters add their records to the chain.'),
        content: const Text(
            'As the spices move through the supply chain, each stakeholder (e.g., a trader or exporter) scans the QR code to verify its origin and add their transaction details, creating a complete digital trail.'),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('4. Consumer Traceability'),
        subtitle: const Text('You scan the code to view the entire history.'),
        content: const Text(
            'When you scan the QR code, our app queries the blockchain, instantly displaying a secure and transparent history of the spice. You can verify its authenticity and support the original farmer.'),
        isActive: _currentStep >= 3,
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
    ];
  }
}