import 'package:flutter/material.dart';
import 'package:glow_application/cart.dart';

Widget AppbarProducts(BuildContext context) {
  return Container(
    height: 150,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF4B2F34), Colors.transparent],
      ),
    ),
    child: SafeArea(
      bottom: false,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Cart()),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
