import 'package:flutter/material.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:glow_application/widgets/popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingForm extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImagePath;
  final double rating;

  const BookingForm({
    Key? key,
    required this.productName,
    required this.productPrice, // now String
    required this.productImagePath,
    required this.rating, // keep as double if rating is a number
  }) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  int quantity = 1;

  String fixedName = "";
  String email = "";
  String phone = "";

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController specialNotesController = TextEditingController();

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        setState(() {
          fixedName =
              (data['firstName'] ?? '') + ' ' + (data['lastName'] ?? '');
          email = data['email'] ?? '';
          phone = data['phone'] ?? '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _showPurchasePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return GlowPopup(
          title: 'Booking Summary',
          headerIcon: Icons.event,
          description:
              'Product: ${widget.productName}\n'
              'Date: ${dateController.text}\n'
              'Time: ${timeController.text}',
          hasTextField: false,
          confirmText: 'Confirm',
          onConfirm: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const SuccessPopup(type: SuccessPopupType.booking);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // product header
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              widget.productImagePath,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.productName,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 253, 125, 148),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Php ${widget.productPrice}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF4B2F34),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // fullname
                      _buildStyledField(
                        label: 'FULLNAME',
                        readOnly: true,
                        value: fixedName,
                      ),
                      const SizedBox(height: 15),

                      // email & phone
                      Row(
                        children: [
                          Expanded(
                            child: _buildStyledField(
                              label: 'EMAIL',
                              initialValue: email,
                              onChanged: (val) => email = val,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return 'Input required';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildStyledField(
                              label: 'PHONE NUMBER',
                              initialValue: phone,
                              onChanged: (val) => phone = val,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return 'Input required';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // date & time row
                      Row(
                        children: [
                          Expanded(
                            child: _buildStyledField(
                              label: 'APPOINTMENT DATE',
                              controller: dateController,
                              icon: Icons.calendar_month,
                              onTapIcon: () async {
                                FocusScope.of(context).unfocus();
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  setState(() {
                                    dateController.text =
                                        "${picked.day}/${picked.month}/${picked.year}";
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return 'Input required';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildStyledField(
                              label: 'APPOINTMENT TIME',
                              controller: timeController,
                              icon: Icons.access_time,
                              onTapIcon: () async {
                                FocusScope.of(context).unfocus();
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    timeController.text =
                                        "${picked.hourOfPeriod}:${picked.minute.toString().padLeft(2, '0')} ${picked.period == DayPeriod.am ? 'AM' : 'PM'}";
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                  return 'Input required';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      _buildStyledField(
                        label: 'SPECIAL NOTES (Optional)',
                        controller: specialNotesController,
                        onChanged: (val) {},
                        maxLines: 4,
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),

            // bottom bar
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 225, 210, 240),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4B2F34).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL:\nPhp ${widget.productPrice}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFF4B2F34),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GlowButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showPurchasePopup();
                      }
                    },
                    text: 'BOOK NOW',
                    color: GlowButtonColor.pink,
                    size: GlowButtonSize.medium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledField({
    required String label,
    String? initialValue,
    bool readOnly = false,
    String? value,
    TextEditingController? controller,
    Function(String)? onChanged,
    IconData? icon,
    VoidCallback? onTapIcon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final TextEditingController _controller =
        controller ?? TextEditingController(text: initialValue ?? value ?? '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF4B2F34),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          validator: validator,
          controller: _controller,
          readOnly: readOnly,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            filled: (initialValue?.isNotEmpty ?? value?.isNotEmpty ?? false),
            fillColor: (initialValue?.isNotEmpty ?? value?.isNotEmpty ?? false)
                ? const Color.fromARGB(255, 248, 234, 217)
                : null,
            suffixIcon: icon != null
                ? IconButton(
                    icon: Icon(icon, color: const Color(0xFF4B2F34)),
                    onPressed: onTapIcon,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
