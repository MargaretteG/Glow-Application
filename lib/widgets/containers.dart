import 'package:flutter/material.dart';

class ContainerBenefits extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const ContainerBenefits({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: iconColor, width: 2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Icon(icon, color: iconColor, size: 35),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              height: 1.1,
              fontFamily: 'Poppins',
              fontSize: 13,
              color: iconColor,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}
