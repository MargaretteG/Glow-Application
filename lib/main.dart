import 'package:flutter/material.dart';
import 'package:glow_application/sign_in.dart';
import 'package:glow_application/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glow_application/widgets/buttons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'package:glow_application/widgets/buttons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GLOW',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE3C4A6)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFC0CB),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TOP PART
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
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
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        Icon(
                          Icons.local_florist_rounded,
                          size: 100,
                          color: Color(0xFFFA8298),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -15),
                          child: const Text(
                            'GLOW',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 80,
                              color: Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -27),
                          child: Text(
                            'by',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: const Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -32),
                          child: Text(
                            'The Executive Facial Care',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: const Color(0xFFFFE8ED),
                              fontWeight: FontWeight.w700,
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
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome to GLOW! Explore, book, and enjoy a world of\nskincare designed to make you shine inside and out. ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 41, 10, 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 40),
                    GlowButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignIn()),
                        );
                      },
                      text: 'SIGN IN',
                      icon: Icons.login,
                      color: GlowButtonColor.pink,
                      size: GlowButtonSize.defaultSize,
                    ),
                    const SizedBox(height: 12),
                    GlowButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUp()),
                        );
                      },
                      text: 'SIGN UP',
                      icon: Icons.app_registration_rounded,
                      color: GlowButtonColor.pink,
                      size: GlowButtonSize.defaultSize,
                    ),

                    // Row(
                    //   children: const [
                    //     Expanded(child: Divider(color: Color(0xFFE3C4A6))),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 20),
                    //       child: Text(
                    //         'or',
                    //         style: TextStyle(
                    //           color: Color(0xFFE3C4A6),
                    //           fontSize: 19,
                    //           fontWeight: FontWeight.w900,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(child: Divider(color: Color(0xFFE3C4A6))),
                    //   ],
                    // ),
                    // const SizedBox(height: 25),
                    // OutlinedButton.icon(
                    //   onPressed: () {},
                    //   icon: const FaIcon(
                    //     FontAwesomeIcons.google,
                    //     color: Color(0xFF7F55B1),
                    //   ),
                    //   label: const Text(
                    //     'Continue with Google',
                    //     style: TextStyle(
                    //       fontSize: 15.0,
                    //       fontWeight: FontWeight.w700,
                    //       color: Color(0xFF7F55B1),
                    //     ),
                    //   ),
                    //   style: OutlinedButton.styleFrom(
                    //     side: const BorderSide(
                    //       color: Color(0xFF7F55B1),
                    //       width: 2,
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 30.0,
                    //       vertical: 18.0,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(40),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 30),
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
