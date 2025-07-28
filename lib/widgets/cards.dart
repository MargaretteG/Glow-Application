import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double price;
  final double rating;
  final String buttonText;
  final VoidCallback onPressed;
  final List<String> category;


  const ServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
    required this.buttonText,
    required this.onPressed,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4B2F34).withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(imagePath, fit: BoxFit.cover, height: 120),
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.brown.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Php ${price.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.brown.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      rating.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown.shade600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Stars
                    Row(
                      children: List.generate(5, (index) {
                        if (index < rating.floor()) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          );
                        } else if (index < rating) {
                          return const Icon(
                            Icons.star_half,
                            color: Colors.amber,
                            size: 16,
                          );
                        } else {
                          return const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color(0xFFFA8298),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      buttonText,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
