import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Wishlist anda kosong, segera tambahkan produk keinginan anda!'),
      ),
    );
  }
}
