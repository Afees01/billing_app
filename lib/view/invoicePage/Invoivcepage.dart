import 'package:flutter/material.dart';

class InvoiceCreationPage extends StatefulWidget {
  const InvoiceCreationPage({super.key});

  @override
  State<InvoiceCreationPage> createState() => _InvoiceCreationPageState();
}

class _InvoiceCreationPageState extends State<InvoiceCreationPage> {
  final TextEditingController customerController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Map<String, dynamic>> invoiceItems = [];

  void addItem() {
    if (productController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      setState(() {
        invoiceItems.add({
          'product': productController.text,
          'quantity': int.parse(quantityController.text),
          'price': double.parse(priceController.text),
        });
        productController.clear();
        quantityController.clear();
        priceController.clear();
      });
    }
  }

  double calculateTotal() {
    return invoiceItems.fold(
        0.0,
        (sum, item) =>
            sum + (item['quantity'] as int) * (item['price'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
                context); // This will navigate back to the previous screen
          },
        ),
        title: const Text(
          'Create Invoice',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: customerController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Customer Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: productController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Product Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Quantity'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Price per Unit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addItem,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Invoice Items:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...invoiceItems.map((item) => _buildInvoiceItemTile(item)).toList(),
            const SizedBox(height: 20),
            Text(
              'Total: \$${calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save Invoice Logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Invoice'),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildInvoiceItemTile(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${item['product']} (x${item['quantity']})',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            '\$${(item['quantity'] * item['price']).toStringAsFixed(2)}',
            style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
