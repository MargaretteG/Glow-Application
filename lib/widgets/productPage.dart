import 'package:flutter/material.dart';
import 'package:glow_application/forms/productForm.dart';
import 'package:glow_application/widgets/appbarProducts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glow_application/widgets/containers.dart';
import 'package:glow_application/widgets/popup.dart';
import 'package:glow_application/widgets/ratings.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:glow_application/widgets/bottomNav.dart';

class ProductPage extends StatelessWidget {
  final String imagePath;
  final String productName;
  final double price;
  final double rating;
  final String description;
  final List<Map<String, dynamic>> benefits;
  // e.g. [{'icon': Icons.eco_outlined, 'color': Colors.green, 'text': 'Organic'}]

  const ProductPage({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.rating,
    required this.description,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      extendBody: true,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER IMAGE + APPBAR
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  AppbarProducts(context),
                ],
              ),

              // PRODUCT TITLE, PRICE, RATING
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        height: 1.1,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        color: Color.fromARGB(255, 253, 125, 148),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.moneyBillWave,
                          color: Color.fromARGB(255, 82, 130, 96),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'PHP ${price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            height: 1.1,
                            fontSize: 16,
                            color: Color(0xFF4B2F34),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            height: 1.1,
                            fontSize: 15,
                            color: Color(0xFF4B2F34),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          );
                        }),
                        const Spacer(),
                        const Text(
                          '500 Sold',
                          style: TextStyle(
                            height: 1.1,
                            fontSize: 13,
                            color: Color(0xFF4B2F34),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              // VISIT CLINIC
              Container(
                color: const Color(0xFFFFF4ED),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.storefront_outlined, color: Color(0xFF4B2F34)),
                    SizedBox(width: 8),
                    Text(
                      'Visit Our Clinic',
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 15,
                        color: Color(0xFF4B2F34),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.navigate_next_rounded, color: Color(0xFF4B2F34)),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              // DESCRIPTION
              Container(
                width: double.infinity,
                color: const Color(0xFFFFF4ED),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        color: Color(0xFF4B2F34),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          height: 1.2,
                          fontSize: 12,
                          color: Color(0xFF4B2F34),
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              // BENEFITS
              Container(
                width: double.infinity,
                color: const Color(0xFFFFF4ED),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Benefits',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        color: Color(0xFF4B2F34),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 30,
                        ),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 15,
                          children: benefits
                              .map(
                                (benefit) => ContainerBenefits(
                                  icon: benefit['icon'] as IconData,
                                  iconColor: benefit['color'] as Color,
                                  text: benefit['text'] as String,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(color: Color(0xFFE3C4A6)),
              ),

              const SizedBox(height: 20),
              // FEEDBACK FORM
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Leave A Feedback',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        color: Color(0xFF4B2F34),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4ED),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Write your feedback here...',
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const StarRating(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GlowButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Feedback submitted!',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Color(0xFFBC6FF1),
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 10,
                                      duration: Duration(seconds: 3),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 15,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  );
                                },
                                text: 'SUBMIT',
                                icon: Icons.done_outline_rounded,
                                color: GlowButtonColor.purple,
                                size: GlowButtonSize.small,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductBottomNav(
        firstButtonIcon: Icons.shopping_cart,
        onFirstPressed: () {},
        secondButtonText: 'RESERVE NOW',
        secondButtonIcon: Icons.shopping_cart_checkout_rounded,
        onSecondPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                child: PurchaseFormSheet(
                  productName: productName,
                  productPrice: price,
                  productImagePath: imagePath,
                  rating: rating,
                ),
              );
            },
          );
        },

        showSecondButton: true,
      ),
    );
  }
}
