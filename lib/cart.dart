import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glow_application/widgets/cartItems.dart';
import 'package:glow_application/widgets/popup.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'imagePath': 'images/product6.png',
      'productName': 'EFC SKIN CARE SET',
      'price': 5000,
      'quantity': 5,
    },
    {
      'imagePath': 'images/product-2.png',
      'productName': 'EFC HAND CREAM',
      'price': 500,
      'quantity': 3,
    },
    {
      'imagePath': 'images/product2.png',
      'productName': 'ANTI AGING FACIAL',
      'price': 6500,
      'quantity': 1,
    },
    {
      'imagePath': 'images/product8.png',
      'productName': 'SMOOTHING LOTION',
      'price': 2200,
      'quantity': 1,
    },
  ];

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return GlowPopup(
          title: 'Remove Item?',
          headerIcon: Icons.delete_forever,
          description:
              'Are you sure you want to delete this item from your cart?',
          hasTextField: false,
          confirmText: 'Delete',
          onConfirm: () {
            setState(() {
              _cartItems.removeAt(index);
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  double _calculateTotalPrice() {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFA8298),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFFFA8298),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(top: 9),
            child: Text(
              'Cart',
              style: GoogleFonts.poppins(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  for (int i = 0; i < _cartItems.length; i++)
                    Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        _confirmDelete(i);
                        return false;
                      },
                      child: CartItem(
                        imagePath: _cartItems[i]['imagePath'],
                        productName: _cartItems[i]['productName'],
                        quantity: _cartItems[i]['quantity'],
                        price:
                            _cartItems[i]['price'] * _cartItems[i]['quantity'],
                        onAdd: () {
                          setState(() {
                            _cartItems[i]['quantity']++;
                          });
                        },
                        onMinus: () {
                          setState(() {
                            if (_cartItems[i]['quantity'] > 1) {
                              _cartItems[i]['quantity']--;
                            }
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, -4), // Shadow goes upward
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFFA8298)),
                      const SizedBox(width: 8),
                      Text(
                        "Pickup Location:",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      Spacer(),
                      Text(
                        "Tanauan Branch",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.payment, color: Color(0xFFFA8298)),
                      const SizedBox(width: 8),
                      Text(
                        "Payment:",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      Spacer(),
                      Text(
                        "Pay at the store",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1, color: Colors.grey, height: 1),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal:",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      Text(
                        "₱${_calculateTotalPrice().toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFA8298),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Confirm action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFA8298),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
