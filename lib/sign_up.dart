import 'package:flutter/material.dart';
import 'package:glow_application/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  String gender = 'Male';
  final List<String> genderOptions = ['Male', 'Female', 'Prefer not to say'];

  String client = 'New Client';
  final List<String> clientOptions = [
    'New Client',
    'Returning Client',
    'Prefer not to say',
  ];

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isEmail = false,
    bool isPhone = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
          ? TextInputType.phone
          : TextInputType.text,
      maxLength: isPhone ? 11 : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        counterText: isPhone ? '' : null,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        if (isEmail) {
          final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
          if (!RegExp(emailPattern).hasMatch(value.trim())) {
            return 'Invalid email';
          }
        }
        if (isPhone) {
          final phonePattern = r'^09\d{9}$';
          if (!RegExp(phonePattern).hasMatch(value.trim())) {
            return 'Invalid phone number';
          }
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Password is required';
        }
        if (value.length < 8) {
          return 'Must be at least 8 characters';
        }
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return 'Include an uppercase letter';
        }
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return 'Include at least one lowercase letter';
        }
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Include at least one digit';
        }
        if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
          return 'Include at least one special character (!@#\$&*~)';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFC0CB),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF4B2F34),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                    child: Opacity(
                      opacity: 0.15,
                      child: Transform.translate(
                        offset: const Offset(20, 30),
                        child: Transform.scale(
                          scale: 1.3,
                          child: Image.asset(
                            'images/bg-1.jpg',
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFFFFE8ED),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Transform.translate(
                          offset: Offset(0, 0),
                          child: Icon(
                            Icons.local_florist_rounded,
                            size: 70,
                            color: Color(0xFFFA8298),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -10),
                          child: const Text(
                            'GLOW',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 40,
                              color: Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: Text(
                            'by',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -22),
                          child: Text(
                            'The Executive Facial Care',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 60,
                            color: Color(0xFFE3C4A6),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    'Create username',
                                    _usernameController,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(child: _buildPasswordField()),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    'First Name',
                                    _firstNameController,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildTextField(
                                    'Last Name',
                                    _lastNameController,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            _buildTextField('Address', _addressController),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    'Email',
                                    _emailController,
                                    isEmail: true,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildTextField(
                                    'Phone Number',
                                    _phoneController,
                                    isPhone: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: gender,
                                    isExpanded: true,
                                    items: genderOptions.map((String g) {
                                      return DropdownMenuItem<String>(
                                        value: g,
                                        child: Text(g),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        gender = newValue!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Gender',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: client,
                                    isExpanded: true,
                                    items: clientOptions.map((String c) {
                                      return DropdownMenuItem<String>(
                                        value: c,
                                        child: Text(c),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        client = newValue!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Client Type',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            GlowButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text
                                      .trim();

                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                              email: email,
                                              password: password,
                                            );

                                    final user = userCredential.user!;
                                    await user.updateDisplayName(
                                      _usernameController.text.trim(),
                                    );

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .set({
                                          'username': _usernameController.text
                                              .trim(),
                                          'firstName': _firstNameController.text
                                              .trim(),
                                          'lastName': _lastNameController.text
                                              .trim(),
                                          'address': _addressController.text
                                              .trim(),
                                          'email': email,
                                          'phone': _phoneController.text.trim(),
                                          'gender': gender,
                                          'clientType': client,
                                          'createdAt':
                                              FieldValue.serverTimestamp(),
                                        });

                                    if (mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const Home(),
                                        ),
                                      );
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    // Keep your existing Firebase error dialog
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Signup Failed'),
                                        content: Text(
                                          e.message ?? 'Unknown error occurred',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              },
                              text: 'SIGN UP',
                              icon: Icons.app_registration_rounded,
                              color: GlowButtonColor.pink,
                              size: GlowButtonSize.defaultSize,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
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
