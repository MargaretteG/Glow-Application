import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glow_application/forms/bookingForm.dart';
import 'package:glow_application/widgets/appbarProducts.dart';
import 'package:glow_application/widgets/containers.dart';
import 'package:glow_application/widgets/ratings.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:glow_application/widgets/bottomNav.dart';

class ServicePage extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productPrice;
  final String productRating;
  final String productDescription;
  final List<Map<String, dynamic>> benefits;

  const ServicePage({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productPrice,
    required this.productRating,
    required this.productDescription,
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
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  AppbarProducts(context),
                ],
              ),

              // Info Section
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
                          productPrice,
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
                          productRating,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF4B2F34),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ...List.generate(5, (index) {
                          double rating = double.tryParse(productRating) ?? 0;
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : (index < rating
                                      ? Icons.star_half
                                      : Icons.star_border),
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                        const Spacer(),
                        const Text(
                          '500 Sold',
                          style: TextStyle(
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
              _InfoBanner(),
              const SizedBox(height: 15),

              _DescriptionSection(productDescription: productDescription),
              const SizedBox(height: 15),

              _BenefitsSection(benefits: benefits),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(color: Color(0xFFE3C4A6)),
              ),

              const SizedBox(height: 20),
              _FeedbackSection(),

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductBottomNav(
        firstButtonIcon: Icons.favorite_sharp,
        onFirstPressed: () {},
        secondButtonText: 'BOOK NOW',
        secondButtonIcon: Icons.calendar_today_rounded,
        onSecondPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              child: BookingForm(
                productName: productName,
                productPrice: productPrice,
                productImagePath: imagePath,
                rating: double.tryParse(productRating) ?? 0.0,
              ),
            ),
          );
        },

        showSecondButton: true,
      ),
    );
  }
}

// — Sub-widgets —

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF4ED),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        children: const [
          Icon(Icons.storefront_outlined, color: Color(0xFF4B2F34)),
          SizedBox(width: 8),
          Text(
            'For Store Pick-up',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF4B2F34),
              fontWeight: FontWeight.w100,
            ),
          ),
          Spacer(),
          Icon(Icons.navigate_next_rounded, color: Color(0xFF4B2F34)),
        ],
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final String productDescription;

  const _DescriptionSection({required this.productDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF4ED),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
            padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
            child: Text(
              productDescription,
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
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  final List<Map<String, dynamic>> benefits;

  const _BenefitsSection({required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF4ED),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
            child: Wrap(
              spacing: 10,
              runSpacing: 15,
              children: benefits.map((benefit) {
                return ContainerBenefits(
                  icon: benefit['icon'],
                  iconColor: benefit['iconColor'],
                  text: benefit['text'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackSection extends StatelessWidget {
  const _FeedbackSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4B2F34).withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your feedback here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }
}
