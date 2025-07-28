import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<DocumentSnapshot> _fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBECEE),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.pink),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("No user data found"));
            }

            final userData = snapshot.data!;
            final fullName = "${userData['firstName']} ${userData['lastName']}";

            return Column(
              children: [
                Container(
                  height: 270,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4B2F34),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60),
                          ),
                          child: Image.asset(
                            'images/bg-1.jpg',
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.pink,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              fullName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userData['username'],
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoCard("Email", userData['email']),
                _buildInfoCard("Phone", userData['phone']),
                _buildInfoCard("Address", userData['address']),
                _buildInfoCard("Gender", userData['gender']),
                _buildInfoCard("Client Type", userData['clientType']),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(_getIconForTitle(title), color: Colors.pink),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'email':
        return Icons.email_outlined;
      case 'phone':
        return Icons.phone_outlined;
      case 'address':
        return Icons.location_on_outlined;
      case 'gender':
        return Icons.person_outline;
      case 'client type':
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }
}
