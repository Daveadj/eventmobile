import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';

Future<Object?> customSignInDialog(
    BuildContext context, String email, bool isSignIn) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => PopScope(
      canPop: false,
      child: Center(
        child: Container(
          height: 400,
          width: 400,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                40,
              ),
            ),
          ),
          child: Center(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/email.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Thank you! An email has been sent to:',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          isSignIn
                              ? 'Please check your inbox to verify'
                              : 'Please check your inbox to reset',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          isSignIn
                              ? 'your email address and follow the'
                              : 'your password and follow the',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const Text(
                          'instructions',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 56),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'CLOSE',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    // ignore: avoid_print
  );
}
