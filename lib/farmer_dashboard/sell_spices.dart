// lib/sell_spices_page.dart

import 'package:flutter/material.dart';

class SellSpicesPage extends StatefulWidget {
  const SellSpicesPage({super.key});

  @override
  State<SellSpicesPage> createState() => _SellSpicesPageState();
}

class _SellSpicesPageState extends State<SellSpicesPage> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  
  // State variables for dropdown and date
  String? _selectedSpice;
  DateTime? _plantedDate;

  // Mock list of 20 spices (The full list now used directly by the dropdown)
  final List<String> _allSpices = [
    'Cardamom', 'Clove', 'Cinnamon', 'Black Pepper', 'Nutmeg',
    'Mace', 'Ginger', 'Turmeric', 'Cumin', 'Coriander',
    'Fenugreek', 'Mustard Seed', 'Saffron', 'Vanilla', 'Asafoetida',
    'Garlic', 'Chilli', 'Bay Leaf', 'Tamarind', 'Star Anise'
  ];
  
  // --- Removed _searchController, _filteredSpices, _filterSpices, and dispose logic for search ---

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Opens the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _plantedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
    );
    if (picked != null && picked != _plantedDate) {
      setState(() {
        _plantedDate = picked;
      });
    }
  }

  // Logic for the final "List Spice" button press
  void _listSpice() {
    if (_formKey.currentState!.validate() && _selectedSpice != null && _plantedDate != null) {
      // Collect all data for submission
      final data = {
        'productName': _productNameController.text,
        'spiceType': _selectedSpice,
        'quantity': _quantityController.text,
        'pricePerUnit': _priceController.text,
        'plantedDate': _plantedDate!.toIso8601String().split('T')[0],
        // Image URL/Path will be handled by the image picker
      };

      // TODO: Implement API call or Firebase database write here
      print('Submitting Spice Data: $data');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Listing ${_productNameController.text} for sale!')),
      );

      // Navigate back to dashboard
      Navigator.pop(context);

    } else if (_selectedSpice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a Spice Type.')),
      );
    } else if (_plantedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the Planted Date.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List a New Spice'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Spice Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 20),

              // 1. Product Name
              _buildTextFormField(
                controller: _productNameController,
                labelText: 'Product Name ',
                icon: Icons.label,
                validator: (value) => value!.isEmpty ? 'Product name is required' : null,
              ),
              const SizedBox(height: 20),

              // 2. Spice Type Dropdown (Now standard dropdown)
              _buildStandardDropdown(),
              const SizedBox(height: 20),

              // 3. Image Upload Field
              _buildImageUploadButton(),
              const SizedBox(height: 20),

              // 4. Quantity and Price Fields (in a row)
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: _quantityController,
                      labelText: 'Quantity (kg)',
                      icon: Icons.scale,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Quantity is required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFormField(
                      controller: _priceController,
                      labelText: 'Price / kg (₹)',
                      icon: Icons.currency_rupee,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Price is required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 5. Date Planted Field
              _buildDatePlantedField(),
              const SizedBox(height: 40),

              // 6. List Spice Button
              ElevatedButton.icon(
                onPressed: _listSpice,
                icon: const Icon(Icons.add_shopping_cart, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('List Spice for Sale', style: TextStyle(fontSize: 20)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB57F3A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Reusable Widget Builders ---

  // Standard TextFormField builder (Unchanged)
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.green.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  // Builds the simplified standard DropdownButton
  Widget _buildStandardDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Select Spice Type'),
          value: _selectedSpice,
          items: _allSpices.map((String spice) {
            return DropdownMenuItem<String>(
              value: spice,
              child: Text(spice),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSpice = newValue;
            });
          },
        ),
      ),
    );
  }

  // Builds the Date Picker button/field (Unchanged)
  Widget _buildDatePlantedField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: Colors.green.shade700),
        title: Text(
          _plantedDate == null
              ? 'Date Spice Planted'
              : 'Date Planted: ${_plantedDate!.toIso8601String().split('T')[0]}',
          style: TextStyle(
            color: _plantedDate == null ? Colors.grey.shade700 : Colors.black,
            fontWeight: _plantedDate == null ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: () => _selectDate(context),
      ),
    );
  }

  // Builds the Image Upload button (Unchanged)
  Widget _buildImageUploadButton() {
    // NOTE: Actual image picking logic (e.g., using image_picker package) is complex
    // This is a placeholder UI element.
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: Implement image picker logic (e.g., pick from gallery/camera)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image Picker placeholder activated!')),
        );
      },
      icon: const Icon(Icons.camera_alt),
      label: const Text('Upload Spice Image (Required)', style: TextStyle(fontSize: 16)),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.green.shade700,
        side: BorderSide(color: Colors.green.shade700, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}