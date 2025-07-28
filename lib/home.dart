import 'package:flutter/material.dart';
import 'package:glow_application/about.dart';
import 'package:glow_application/cart.dart';
import 'package:glow_application/main.dart';
import 'package:glow_application/notificatins.dart';
import 'package:glow_application/profile.dart';
import 'package:glow_application/services/products/items.dart';
import 'package:glow_application/settings.dart';
import 'package:glow_application/wishlist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:glow_application/widgets/popup.dart';
import 'package:glow_application/widgets/productPage.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:glow_application/widgets/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedCategory = 0;
  String displayName = '';
  String? email;

  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  List<ServiceCard> getFilteredItems(BuildContext context) {
    List<ServiceCard> items = getAllServiceItems(context);

    // Filter by selected category if not ALL
    if (selectedCategory != 0) {
      String selected = '';
      switch (selectedCategory) {
        case 1:
          selected = 'FACE';
          break;
        case 2:
          selected = 'BODY';
          break;
        case 3:
          selected = 'ARMS';
          break;
        case 4:
          selected = 'LEGS';
          break;
        case 5:
          selected = 'PRODUCTS';
          break;
      }

      items = items.where((item) {
        if (item.category is List<String>) {
          return item.category.contains(selected);
        } else if (item.category is String) {
          return item.category == selected;
        }
        return false;
      }).toList();
    }

    // Filter by search
    if (searchQuery.isNotEmpty) {
      items = items
          .where(
            (item) =>
                item.title.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    return items;
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();

    // ✅ Listen for search
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  Future<void> _fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    email = user.email;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data();
      if (data != null && data.containsKey('firstName')) {
        setState(() {
          displayName = data['firstName'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFFA8298)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_florist_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'GLOW',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Cart()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Wishlist'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WishlistPage()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return GlowPopup(
                      title: 'Log Out?',
                      headerIcon: Icons.logout,
                      description: 'Already leaving?',
                      hasTextField: false,
                      confirmText: 'Log Out',
                      onConfirm: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MyHomePage()),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFFFA8298),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(top: 9),
            child: const Icon(
              Icons.local_florist_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B2F34),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(100),
                        ),
                        child: Opacity(
                          opacity: 0.15,
                          child: Image.asset(
                            'images/bg-home.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Welcome to',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: const Color(0xFFFFE8ED),
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.local_florist_rounded,
                                color: Color(0xFFFFE8ED),
                                size: 24,
                              ),
                              Text(
                                'GLOW',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: const Color(0xFFFFE8ED),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: const Offset(0, -10),
                            child: Text(
                              displayName,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 50,
                                color: Color(0xFFFFE8ED),
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et ',
                            style: GoogleFonts.poppins(
                              height: 1.1,
                              fontSize: 12,
                              color: const Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.80,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF4ED),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _searchController, // ✅ added
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.brown.shade900,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'SEARCH',
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.brown.shade700
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.0,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 5,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE3C4A6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {}, // optional
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 0),
                        child: Row(
                          children: [
                            CategoryButton(
                              text: 'ALL',
                              icon: Icons.category_rounded,
                              isSelected: selectedCategory == 0,
                              onTap: () {
                                setState(() {
                                  selectedCategory = 0;
                                });
                              },
                            ),
                            CategoryButton(
                              text: 'FACE',
                              icon: Icons.face_retouching_natural,
                              isSelected: selectedCategory == 1,
                              onTap: () {
                                setState(() {
                                  selectedCategory = 1;
                                });
                              },
                            ),
                            CategoryButton(
                              text: 'BODY',
                              icon: Icons.accessibility_new_rounded,
                              isSelected: selectedCategory == 2,
                              onTap: () {
                                setState(() {
                                  selectedCategory = 2;
                                });
                              },
                            ),
                            CategoryButton(
                              text: 'ARMS',
                              icon: Icons.clean_hands_outlined,
                              isSelected: selectedCategory == 3,
                              onTap: () {
                                setState(() {
                                  selectedCategory = 3;
                                });
                              },
                            ),
                            CategoryButton(
                              text: 'LEGS',
                              icon: Icons.directions_walk_rounded,
                              isSelected: selectedCategory == 4,
                              onTap: () {
                                setState(() {
                                  selectedCategory = 4;
                                });
                              },
                            ),
                            CategoryButton(
                              text: 'PRODUCTS',
                              icon: Icons.auto_awesome_rounded,
                              isSelected: selectedCategory == 5,
                              onTap: () {
                                setState(() {
                                  selectedCategory = 5;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        // ✅ Build filtered items
                        children: getFilteredItems(context),
                      ),
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
