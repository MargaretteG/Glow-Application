import 'package:flutter/material.dart';

class GlowPopup extends StatelessWidget {
  final String title;
  final IconData headerIcon; // 👈 editable icon
  final String description;
  final bool hasTextField;
  final String confirmText;
  final VoidCallback onConfirm;
  final TextEditingController? textController;

  const GlowPopup({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.description,
    required this.onConfirm,
    this.confirmText = 'OK',
    this.hasTextField = false,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        textController ?? TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 HEADER WITH ICON AND CLOSE BUTTON
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFA8298),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  headerIcon,
                  color: Colors.white,
                  size: 24,
                ), // editable icon
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 255, 61, 61),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // ✨ BODY CONTENT
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 41, 10, 0),
                  ),
                  textAlign: TextAlign.start,
                ),
                if (hasTextField) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter here...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CANCEL BUTTON (lighter purple)
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 239, 255),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
                const SizedBox(width: 5),

                // CONFIRM BUTTON (purple)
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7F55B1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    confirmText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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

enum SuccessPopupType { reservation, booking, custom }

class SuccessPopup extends StatefulWidget {
  final SuccessPopupType type;
  final String? customMessage;
  final IconData? customIcon;

  const SuccessPopup({
    super.key,
    this.type = SuccessPopupType.reservation,
    this.customMessage,
    this.customIcon,
  });

  @override
  State<SuccessPopup> createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup> {
  late String message;
  late IconData icon;

  @override
  void initState() {
    super.initState();
    _configurePopup();
    // Auto close after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  void _configurePopup() {
    switch (widget.type) {
      case SuccessPopupType.reservation:
        message = "Successful Reservation!";
        icon = Icons.check_circle_rounded;
        break;
      case SuccessPopupType.booking:
        message = "Successful Booking!";
        icon = Icons.event_available_rounded;
        break;
      case SuccessPopupType.custom:
        message = widget.customMessage ?? "Success!";
        icon = widget.customIcon ?? Icons.check_circle_rounded;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(40),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 60,
              color: const Color(0xFF7F55B1), // match aesthetic
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4B2F34),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
