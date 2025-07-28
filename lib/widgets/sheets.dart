import 'package:flutter/material.dart';

class PurchaseFormSheet extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final Widget formContents; // you can also pass fields, etc.

  const PurchaseFormSheet({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.formContents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 👇 style matches your design
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: formContents, // this is your entire Column with image, fields, etc.
        ),
      ),
    );
  }
}
