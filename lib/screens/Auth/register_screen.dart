// ignore_for_file: use_build_context_synchronously

import 'package:eventmobile/models/register_model.dart';
import 'package:eventmobile/provider/auth_notifier.dart';
import 'package:eventmobile/screens/Auth/email_sent_dialog.dart';
import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:eventmobile/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  GlobalKey<FormState> formfield = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obsscureConfirmPassword = true;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
                            controller: firstNameController,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return Validator.nameValidator(value!);
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
                            controller: lastNameController,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return Validator.nameValidator(value!);
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
                            controller: userNameController,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return Validator.userNameValidator(value!);
                            },
                            label: 'UserName',
                            hintText: 'UserName',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormField(
                            controller: emailController,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                            validator: (String? value) {
                              return Validator.emailValidator(value!);
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
                            controller: passwordController,
                            validator: (String? value) {
                              return Validator.passwordValidator(value!);
                            },
                            label: 'Password',
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                            obscureText: obscurePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputFormField(
                            controller: confirmPasswordController,
                            validator: (String? value) {
                              if (value != passwordController.text) {
                                return 'Password do not match';
                              } else {
                                return null;
                              }
                            },
                            label: 'Confirm Password',
                            hintText: 'Confirm Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obsscureConfirmPassword =
                                      !obsscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                obsscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                            obscureText: obsscureConfirmPassword,
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
                              onPressed: () async {
                                if (formfield.currentState!.validate()) {
                                  var register = Register(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      userName: userNameController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text,
                                      email: emailController.text);

                                   await ref
                                      .read(authNotifierProvider.notifier)
                                      .registerUser(context, register);
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
