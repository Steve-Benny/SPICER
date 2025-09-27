// lib/cart_page.dart

import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  final int quantity;

  const CartItem({required this.name, required this.price, required this.quantity});
  double get total => price * quantity;
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  
  final List<CartItem> _cartItems = const [
    CartItem(name: 'Idukki Cardamom', price: 1550.0, quantity: 2),
    CartItem(name: 'Black Pepper (Grade A)', price: 680.0, quantity: 5),
  ];

  double get _subtotal => _cartItems.fold(0.0, (sum, item) => sum + item.total);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: _cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) => _buildCartItemTile(_cartItems[index]),
                  ),
                ),
                _buildCheckoutSummary(context),
              ],
            ),
    );
  }

  Widget _buildCartItemTile(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('₹${item.price.toStringAsFixed(2)} / kg'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Qty: ${item.quantity} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Total: ₹${item.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:', style: TextStyle(fontSize: 16)),
              Text('₹${_subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Proceeding to Secure Checkout!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}