import 'package:flutter/material.dart';

enum GlowButtonColor { pink, purple }

/// ✅ Added medium size
enum GlowButtonSize { defaultSize, small, medium }

class GlowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  final GlowButtonColor color;
  final GlowButtonSize size;
  final bool outlined;

  const GlowButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.color = GlowButtonColor.pink,
    this.size = GlowButtonSize.defaultSize,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🎨 Define colors
    const pinkColor = Color(0xFFFA8298);
    const purpleColor = Color(0xFF7F55B1);

    // 📏 Define sizes
    final verticalPadding = () {
      switch (size) {
        case GlowButtonSize.defaultSize:
          return 15.0;
        case GlowButtonSize.small:
          return 12.0;
        case GlowButtonSize.medium:
          return 17.0;
      }
    }();

    final horizontalPadding = size == GlowButtonSize.defaultSize ? 60.0 : 13.0;
    final fontSize = size == GlowButtonSize.defaultSize ? 20.0 : 15.0;
    final iconSize = size == GlowButtonSize.defaultSize ? 20.0 : 18.0;

    // ✨ Choose color
    final mainColor = color == GlowButtonColor.pink ? pinkColor : purpleColor;

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: mainColor, width: 2),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: mainColor, size: iconSize),
              if (text != null) const SizedBox(width: 8),
            ],
            if (text != null) ...[
              Text(
                text!,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: mainColor,
                ),
              ),
            ],
          ],
        ),
      );
    } else {
      // 🌟 Filled Button
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 6,
          shadowColor: mainColor.withOpacity(0.6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: iconSize),
              const SizedBox(width: 8),
            ],
            Text(
              text!,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Your chosen purple
    final Color purple = const Color(0xFF7F55B1);

    final Color bgColor = isSelected ? purple : Colors.transparent;
    final Color borderColor = isSelected ? purple : purple;
    final Color iconTextColor = isSelected ? Colors.white : purple;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor, width: 1.5),
          // inner white shadow (simulated using BoxShadow)
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color(0xFF7F55B1).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 3.5,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconTextColor, size: 25),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: iconTextColor,
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
