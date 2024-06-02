import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String routerName = 'products';

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Products'))),
      body: const Center(
        child: Text('ProductScreen'),
      ),
    );
  }
}
