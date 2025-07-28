import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String imagePath;
  final String productName;
  final int quantity;
  final int price;
  final VoidCallback onAdd;
  final VoidCallback onMinus;
 
  const CartItem({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.onAdd,
    required this.onMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF4ED),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            // Product Image with decoration
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 251, 225, 209),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4B2F34).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.width * 0.27,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 15),

            // Product name and price
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      height: 1.1,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      color: Color(0xFF4B2F34),
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    'PHP $price',
                    style: const TextStyle(
                      height: 1.1,
                      fontSize: 15,
                      color: Color(0xFF4B2F34),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Quantity box
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 251, 225, 209),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4B2F34).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add_circle_outline),
                      color: Colors.pinkAccent,
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: onMinus,
                      icon: const Icon(Icons.remove_circle_outline),
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
