import 'package:flutter/material.dart';
import 'package:shop/route/screen_export.dart';
import 'package:shop/screens/product/views/product_details_screen.dart';
import 'package:shop/services/product-service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

