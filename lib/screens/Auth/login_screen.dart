import 'package:eventmobile/logging.dart';
import 'package:eventmobile/screens/Auth/forgot_password_screen.dart';
import 'package:eventmobile/screens/entryPoint/entry_point.dart';
import 'package:eventmobile/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formfield = GlobalKey<FormState>();
   final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailValidator(String value) {
    bool emailValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isEmpty) {
      return 'Enter Email';
    } else if (!emailValid) {
      return 'Enter a Valid Email';
    } else {
      return null;
    }
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Enter Password';
    } else if (value.length < 8) {
      return 'Password Length should be more than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const OnboardingScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Welcome\nBack!',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const Text(
                        'continue your adventure',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formfield,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InputFormField(
                            controller: emailController,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return emailValidator(value!);
                            },
                            label: 'Email',
                            hintText: 'Email',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InputFormField(
                            controller: passwordController,
                            validator: (String? value) {
                              return passwordValidator(value!);
                            },
                            label: 'Password',
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.white,
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
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
                                if (formfield.currentState!.validate()) {
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => const EntryPoint(),
                                        ),
                                      );
                                      Log.i('login successfull');
                                    },
                                  );
                                  Log.i('user logging in');
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                        child: SpinKitWave(
                                          color: Colors.white,
                                          size: 50.0,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const ForgotPassword(),
                                ),
                              );
                            },
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputFormField extends StatelessWidget {
  const InputFormField(
      {super.key,
      required this.validator,
      required this.label,
      required this.hintText,
      this.textInputType,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon, required this.controller});

  final String? Function(String? value) validator;
  final String label;
  final String hintText;
  final TextInputType? textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: prefixIcon,
          label: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          suffixIcon: suffixIcon,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: validator);
  }
}
