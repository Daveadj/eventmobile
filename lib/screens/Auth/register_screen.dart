import 'package:eventmobile/screens/Auth/email_sent_dialog.dart';
import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:eventmobile/screens/onboarding.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formfield = GlobalKey<FormState>();
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

  String? userNameValidator(String value) {
    if (value.isEmpty) {
      return 'Enter UserName';
    } else if (value.length < 2 || value.length > 10) {
      return 'Name Length should be between 2 to 10 characters';
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
              height: 220,
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
                        'Create\nAccount',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
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
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return userNameValidator(value!);
                            },
                            label: 'First Name',
                            hintText: 'First Name',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormField(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return userNameValidator(value!);
                            },
                            label: 'Last Name',
                            hintText: 'Last Name',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormField(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return userNameValidator(value!);
                            },
                            label: 'User Name',
                            hintText: 'User Name',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormField(
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
                            height: 10,
                          ),
                          InputFormField(
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
                            height: 10,
                          ),
                          InputFormField(
                            validator: (String? value) {
                              return passwordValidator(value!);
                            },
                            label: 'Confirm Password',
                            hintText: 'Confirm Password',
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
                            height: 25,
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
                                  customSignInDialog(context);
                                }
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
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
