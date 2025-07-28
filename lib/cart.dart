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
      'productName': 'EFC WHITENING SET',
      'price': 3000,
      'quantity': 3,
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
      body: SingleChildScrollView(
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
                  price: _cartItems[i]['price'] * _cartItems[i]['quantity'],
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
    );
  }
}
