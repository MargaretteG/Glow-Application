import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, dynamic>> wishlistItems = [
    {
      'name': 'DIAMOND FACIAL TREATMENT',
      'price': 899,
      'image': 'images/product10.jpg',
    },
    {'name': 'EFC HYDRA FACIAL', 'price': 499, 'image': 'images/product1.jpg'},
    // Add more items as needed
  ];

  void removeFromWishlist(int index) {
    setState(() {
      wishlistItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F6),
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
              'Wishlist',
              style: GoogleFonts.poppins(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: wishlistItems.isEmpty
          ? const Center(
              child: Text(
                'No items in your wishlist.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFD9D9D9),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Image.asset(
                              item['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "PHP ${item['price']}",
                                    style: const TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => removeFromWishlist(index),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
