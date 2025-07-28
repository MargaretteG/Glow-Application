import 'package:flutter/material.dart';
import 'package:glow_application/widgets/cards.dart';
import 'package:glow_application/widgets/productPage.dart';
import 'package:glow_application/widgets/servicePage.dart';

List<ServiceCard> getAllServiceItems(BuildContext context) {
  return [
    // --- SERVICE ---
    ServiceCard(
      imagePath: 'images/product1.jpg',
      title: 'EFC HYDRA FACIAL',
      price: 5000,
      rating: 4.0,
      buttonText: 'BOOK NOW',
      category: ['FACE'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServicePage(
              imagePath: 'images/product1.jpg',
              productName: 'EFC HYDRA FACIAL',
              productPrice: 'PHP 5 000',
              productRating: '4.0',
              productDescription:
                  'A deeply hydrating facial treatment that exfoliates, extracts, and infuses the skin with nourishing serums, perfect for revitalizing dull complexions.',
              benefits: [
                {
                  'icon': Icons.eco_outlined,
                  'iconColor': Colors.green,
                  'text': 'Organic',
                },
                {
                  'icon': Icons.opacity,
                  'iconColor': Colors.blue,
                  'text': 'Hydrating',
                },
                {
                  'icon': Icons.face,
                  'iconColor': Colors.orange,
                  'text': 'Glow Boost',
                },
                {
                  'icon': Icons.spa,
                  'iconColor': Colors.pink,
                  'text': 'Deep Cleanse',
                },
                {
                  'icon': Icons.auto_awesome,
                  'iconColor': Colors.yellow,
                  'text': 'Brightening',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- PRODUCT ---
    ServiceCard(
      imagePath: 'images/product2.png',
      title: 'ANTI-AGING FACIAL',
      price: 6500,
      rating: 4.5,
      buttonText: 'VIEW NOW',
      category: ['PRODUCTS', 'FACE'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(
              imagePath: 'images/product2.png',
              productName: 'ANTI-AGING FACIAL',
              price: 6500,
              rating: 4.5,
              description:
                  'Targets fine lines, sagging, and wrinkles through collagen-boosting serums and radio-frequency technology for firmer and youthful skin.',
              benefits: [
                {
                  'icon': Icons.face_4,
                  'color': Colors.purple,
                  'text': 'Tightening',
                },
                {
                  'icon': Icons.timer_outlined,
                  'color': Colors.grey,
                  'text': 'Anti-Wrinkle',
                },
                {
                  'icon': Icons.auto_fix_high,
                  'color': Colors.teal,
                  'text': 'Firming',
                },
                {
                  'icon': Icons.healing,
                  'color': Colors.deepOrange,
                  'text': 'Regenerating',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- PRODUCT ---
    ServiceCard(
      imagePath: 'images/product3.png',
      title: 'BODY POLISH SCRUB',
      price: 3000,
      rating: 4.3,
      buttonText: 'VIEW NOW',
      category: ['PRODUCTS', 'BODY'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(
              imagePath: 'images/product3.png',
              productName: 'BODY POLISH SCRUB',
              price: 3000,
              rating: 4.3,
              description:
                  'An exfoliating full-body treatment that removes dead skin cells, hydrates, and restores the body\'s natural glow.',
              benefits: [
                {
                  'icon': Icons.spa,
                  'color': Colors.orangeAccent,
                  'text': 'Smoothing',
                },
                {
                  'icon': Icons.water_drop,
                  'color': Colors.cyan,
                  'text': 'Moisturizing',
                },
                {
                  'icon': Icons.brightness_5,
                  'color': Colors.amber,
                  'text': 'Radiance',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- SERVICE ---
    ServiceCard(
      imagePath: 'images/product4.jpg',
      title: 'ARM WHITENING TREATMENT',
      price: 2800,
      rating: 4.2,
      buttonText: 'BOOK NOW',
      category: ['ARMS'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServicePage(
              imagePath: 'images/product4.jpg',
              productName: 'EFC ARM WHITENING TREATMENT',
              productPrice: 'PHP 2 800',
              productRating: '4.2',
              productDescription:
                  'Designed to lighten and smoothen the arm area using a blend of safe whitening agents and exfoliants.',
              benefits: [
                {
                  'icon': Icons.light_mode,
                  'iconColor': Colors.yellowAccent,
                  'text': 'Whitening',
                },
                {
                  'icon': Icons.layers_clear,
                  'iconColor': Colors.blueGrey,
                  'text': 'Exfoliating',
                },
                {
                  'icon': Icons.clean_hands,
                  'iconColor': Colors.pinkAccent,
                  'text': 'Gentle Formula',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- SERVICE ---
    ServiceCard(
      imagePath: 'images/product5.jpg',
      title: 'CELLULITE TREATMENT',
      price: 4800,
      rating: 4.4,
      buttonText: 'BOOK NOW',
      category: ['LEGS'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServicePage(
              imagePath: 'images/product5.jpg',
              productName: 'EFC CELLULITE TREATMENT',
              productPrice: 'PHP 4 800',
              productRating: '4.4',
              productDescription:
                  'Targets cellulite and uneven skin texture using vacuum therapy and serum infusion for smoother legs.',
              benefits: [
                {
                  'icon': Icons.grain,
                  'iconColor': Colors.greenAccent,
                  'text': 'Firming',
                },
                {
                  'icon': Icons.device_thermostat,
                  'iconColor': Colors.orange,
                  'text': 'Circulation Boost',
                },
                {
                  'icon': Icons.auto_fix_normal,
                  'iconColor': Colors.indigo,
                  'text': 'Smoothing',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- PRODUCT ---
    ServiceCard(
      imagePath: 'images/product6.png',
      title: 'EFC GLOWING SKIN SET',
      price: 5200,
      rating: 4.1,
      buttonText: 'VIEW NOW',
      category: ['PRODUCTS', 'FACE'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(
              imagePath: 'images/product6.png',
              productName: 'EFC GLOWING SKIN SET',
              price: 5200,
              rating: 4.1,
              description:
                  'A complete skincare set that brightens dull skin, balances oil production, and improves hydration for everyday skin wellness.',
              benefits: [
                {
                  'icon': Icons.water_drop,
                  'color': Colors.lightBlue,
                  'text': 'Hydrating',
                },
                {
                  'icon': Icons.flash_on,
                  'color': Colors.yellow,
                  'text': 'Brightening',
                },
                {
                  'icon': Icons.eco,
                  'color': Colors.green,
                  'text': 'Natural Ingredients',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- PRODUCT ---
    ServiceCard(
      imagePath: 'images/product7.png',
      title: 'AROMA THERAPY OIL',
      price: 1500,
      rating: 4.7,
      buttonText: 'VIEW NOW',
      category: ['PRODUCTS', 'FACE'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(
              imagePath: 'images/product7.png',
              productName: 'AROMA THERAPY OIL',
              price: 1500,
              rating: 4.7,
              description:
                  'A relaxing oil infused with essential herbs to soothe muscles and uplift the senses during massage or home use.',
              benefits: [
                {
                  'icon': Icons.self_improvement,
                  'color': Colors.deepPurple,
                  'text': 'Stress Relief',
                },
                {
                  'icon': Icons.eco,
                  'color': Colors.green,
                  'text': 'Organic Blend',
                },
                {
                  'icon': Icons.waves,
                  'color': Colors.blueAccent,
                  'text': 'Calming',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- PRODUCT ---
    ServiceCard(
      imagePath: 'images/product8.png',
      title: 'LEG SMOOTHING LOTION',
      price: 2200,
      rating: 4.6,
      buttonText: 'VIEW NOW',
      category: ['PRODUCTS', 'LEGS'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(
              imagePath: 'images/product8.png',
              productName: 'LEG SMOOTHING LOTION',
              price: 2200,
              rating: 4.6,
              description:
                  'A nutrient-rich lotion designed to smoothen and hydrate legs, leaving them soft and radiant all day long.',
              benefits: [
                {
                  'icon': Icons.water_drop,
                  'color': Colors.lightBlueAccent,
                  'text': 'Hydrating',
                },
                {
                  'icon': Icons.star,
                  'color': Colors.amber,
                  'text': 'Silky Finish',
                },
                {
                  'icon': Icons.healing,
                  'color': Colors.pinkAccent,
                  'text': 'Revitalizing',
                },
              ],
            ),
          ),
        );
      },
    ),

    // --- SERVICE ---
    ServiceCard(
      imagePath: 'images/product10.jpg',
      title: 'DIAMOND FACIAL TREATMENT',
      price: 4200,
      rating: 4.8,
      buttonText: 'BOOK NOW',
      category: ['FACE'],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServicePage(
              imagePath: 'images/product10.jpg',
              productName: 'DIAMOND FACIAL',
              productPrice: 'PHP 4 200',
              productRating: '4.8',
              productDescription:
                  'An anti-aging facial treatment that uses diamond microdermabrasion to deeply exfoliate and rejuvenate skin.',
              benefits: [
                {
                  'icon': Icons.auto_awesome,
                  'iconColor': Colors.amberAccent,
                  'text': 'Anti-Aging',
                },
                {
                  'icon': Icons.face,
                  'iconColor': Colors.pinkAccent,
                  'text': 'Brightening',
                },
                {
                  'icon': Icons.spa,
                  'iconColor': Colors.lime,
                  'text': 'Revitalizing',
                },
              ],
            ),
          ),
        );
      },
    ),
  ];
}
