import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF4E342E);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFFFA8298),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          elevation: 0,
          title: Container(
            margin: const EdgeInsets.only(top: 9),
            child: Text(
              'About',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200, // Or your preferred size
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4B2F34).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_florist_rounded,
                          size: 70,
                          color: Color(0xFFFA8298),
                        ),

                        const Text(
                          'GLOW',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            color: Color(0xFFFA8298),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const Text(
                          'by',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFFA8298),
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const Text(
                          'The Executive Facial Care',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFFA8298),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text(
                'We at Glow are committed to providing the best skin care treatments using top-grade products, handled by professionals.',
                style: GoogleFonts.poppins(fontSize: 16, color: darkBrown),
              ),
              const SizedBox(height: 24),
              const InfoCard(
                icon: Icons.location_on,
                title: 'Location',
                description:
                    'Shekinah Bldg. Pres. Laurel Highway, Poblacion 4232 Tanauan, Philippines',
              ),
              const InfoCard(
                icon: Icons.phone,
                title: 'Contact',
                description: '+63 912 345 6789',
              ),
              const InfoCard(
                icon: Icons.access_time,
                title: 'Operating Hours',
                description: 'Mon-Sat: 9AM - 6PM',
              ),
              const SizedBox(height: 28),
              Text(
                'Where to find us:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'images/map.png',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF4E342E);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white, // soft peach tone
      child: ListTile(
        leading: Icon(icon, color: Color(0xFFFA8298), size: 28),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: darkBrown,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.poppins(color: darkBrown),
        ),
      ),
    );
  }
}
