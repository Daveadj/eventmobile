// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:eventmobile/screens/Auth/register_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: pageModel.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(pageModel[index].image),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pageModel[index].text,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 300,
                          ),
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  3,
                                  (indexDots) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 2),
                                      height: 8,
                                      width: index == indexDots ? 30 : 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: index == indexDots
                                              ? Colors.blue
                                              : Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  if (index < pageModel.length - 1) {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  } else {
                                    _pageController.jumpToPage(0);
                                  }
                                },
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 210,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                ),
              ),
              // ignore: prefer_const_constructors
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get invovled with events and people\naround you',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade900,
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
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Or Create Account',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.black,
                            size: 50,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageModel {
  final String text;
  final String image;
  PageModel({
    required this.text,
    required this.image,
  });
}

final List<PageModel> pageModel = [
  PageModel(
      text: 'Start a new \nsocial adventure.',
      image: 'assets/images/person.jpeg'),
  PageModel(text: 'Attend\nnearby event', image: 'assets/images/party2.jpg'),
  PageModel(text: 'Explore\nPlaces', image: 'assets/images/tower.jpeg'),
];
