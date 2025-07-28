import 'package:flutter/material.dart';
import 'package:glow_application/widgets/buttons.dart';

class ProductBottomNav extends StatelessWidget {
  final String? firstButtonText;
  final IconData firstButtonIcon;
  final VoidCallback? onFirstPressed;

  final String? secondButtonText;
  final IconData? secondButtonIcon;
  final VoidCallback? onSecondPressed;

  /// if false → only show one button and make it **filled**
  final bool showSecondButton;

  const ProductBottomNav({
    super.key,
    this.firstButtonText,
    required this.firstButtonIcon,
    required this.onFirstPressed,
    this.secondButtonText,
    this.secondButtonIcon,
    this.onSecondPressed,
    this.showSecondButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4B2F34).withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GlowButton(
              onPressed: onFirstPressed ?? () {},
              text: firstButtonText,
              icon: firstButtonIcon,
              color: GlowButtonColor.pink,
              size: GlowButtonSize.medium,
              outlined: showSecondButton,
            ),

            if (showSecondButton &&
                secondButtonText != null &&
                secondButtonIcon != null) ...[
              const SizedBox(width: 10),
              GlowButton(
                onPressed: onSecondPressed ?? () {},
                text: secondButtonText!,
                icon: secondButtonIcon!,
                color: GlowButtonColor.pink,
                size: GlowButtonSize.medium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
