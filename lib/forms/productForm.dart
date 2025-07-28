import 'package:flutter/material.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:glow_application/widgets/popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseFormSheet extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String productImagePath;
  final double rating;

  const PurchaseFormSheet({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImagePath,
    required this.rating,
  });

  @override
  State<PurchaseFormSheet> createState() => _PurchaseFormSheetState();
}

class _PurchaseFormSheetState extends State<PurchaseFormSheet> {
  final _formKey = GlobalKey<FormState>();
  int quantity = 1;
  late double pricePerItem;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    pricePerItem = widget.productPrice;
  }

  String fixedName = "";
  String email = "";
  String phone = "";

  final TextEditingController promoController = TextEditingController();
  final TextEditingController pickUpController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController specialNotesController = TextEditingController();

  String selectedPayment = 'Pay at the store';

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double get totalPrice => pricePerItem * quantity;

  void _showPurchasePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return GlowPopup(
          title: 'Purchase Summary',
          headerIcon: Icons.shopping_bag_rounded,
          description:
              'Product: EFC SKIN CARE SET\nQuantity: $quantity\nTotal: Php ${totalPrice.toStringAsFixed(0)}',
          hasTextField: false,
          confirmText: 'Confirm',
          onConfirm: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const SuccessPopup(type: SuccessPopupType.reservation);
              },
            );
          },
        );
      },
    );
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // no signed in user

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        setState(() {
          // assuming your Firestore fields are named like this:
          fixedName =
              (data['firstName'] ?? '') + ' ' + (data['lastName'] ?? '');
          email = data['email'] ?? '';
          phone = data['phone'] ?? '';
        });
      }
    }
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
                                  'Php ${widget.productPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF4B2F34),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: _decreaseQuantity,
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      color: Colors.pinkAccent,
                                    ),
                                    Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _increaseQuantity,
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                      color: Colors.pinkAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildStyledField(
                        label: 'FULLNAME',
                        readOnly: true,
                        value: fixedName,
                      ),
                      const SizedBox(height: 15),
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
                      Row(
                        children: [
                          Expanded(
                            child: _buildStyledField(
                              label: 'PROMO CODE',
                              controller: promoController,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildStyledField(
                              label: 'EXPECTED PICK UP',
                              controller: pickUpController,
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
                                    pickUpController.text =
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
                        ],
                      ),
                      const SizedBox(height: 15),
                      _buildDropdown(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty)
                            return 'Input required';
                          return null;
                        },
                      ),
                      const SizedBox(height: 50), // spacing for bottom bar
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
                    'TOTAL:\nPhp ${totalPrice.toStringAsFixed(0)}',
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
                    text: 'PURCHASE',
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

  Widget _buildDropdown({String? Function(String?)? validator}) {
    return FormField<String>(
      initialValue: selectedPayment,
      validator: validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PAYMENT METHOD',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF4B2F34),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                errorText: state.errorText,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPayment.isNotEmpty ? selectedPayment : null,
                  isExpanded: true,
                  onChanged: (val) {
                    setState(() {
                      selectedPayment = val!;
                      state.didChange(
                        val,
                      ); // inform the FormField of the change
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'Pay at the store',
                      child: Text('Pay at the store'),
                    ),
                    // Add more options if needed
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
