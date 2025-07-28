import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
              'Notifications',
              style: GoogleFonts.poppins(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNotificationCard(
              icon: Icons.shopping_bag,
              title: 'Product Ready',
              description: 'Your product is now ready for pickup!',
              time: 'Just now',
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              icon: Icons.check_circle_outline,
              title: 'Appointment Approved',
              description: 'Your appointment for facial procedure is approved.',
              time: '2 hrs ago',
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              icon: Icons.local_shipping_outlined,
              title: 'Item Shipped',
              description: 'Your Glow Set has been shipped out for delivery!',
              time: 'Yesterday',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.shade100.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFA8298).withOpacity(0.2),
            radius: 28,
            child: Icon(icon, color: const Color(0xFFFA8298), size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade500,
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
