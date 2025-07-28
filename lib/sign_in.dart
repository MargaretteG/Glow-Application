import 'package:flutter/material.dart';
import 'package:glow_application/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:glow_application/widgets/popup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        // ✅ Firebase email sign-in
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // ✅ If successful, go to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Home()),
        );
      } on FirebaseAuthException catch (e) {
        // ✅ Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Sign In Failed"),
            content: Text(e.message ?? "Unknown error"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
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
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFC0CB),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: true,
      //   iconTheme: const IconThemeData(color: Color(0xFFFFE8ED)),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF4B2F34),
                borderRadius: const BorderRadius.only(
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
                        Transform.translate(
                          offset: const Offset(0, -15),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 60,
                              color: Color(0xFFE3C4A6),
                              fontWeight: FontWeight.w900,
                            ),
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
              decoration: const BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(100),
                //   topRight: Radius.circular(100),
                // ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),

                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            _buildTextField('Email', _emailController),
                            const SizedBox(height: 20),
                            _buildPasswordField(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GlowPopup(
                                        title: 'Reset Password?',
                                        headerIcon: Icons.lock_reset_rounded,
                                        description:
                                            'Enter your email to receive a password reset link.',
                                        hasTextField: true,
                                        confirmText: 'Send Email',
                                        onConfirm: () {
                                          // Do your logic
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Color(0xFFE3C4A6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 50),
                            GlowButton(
                              onPressed: _signIn,
                              text: 'SIGN IN',
                              icon: Icons.login,
                              color: GlowButtonColor.pink,
                              size: GlowButtonSize.defaultSize,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
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
