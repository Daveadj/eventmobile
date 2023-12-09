import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventmobile/screens/home/home_screen.dart';
import 'package:eventmobile/screens/profile/profile_screen.dart';
import 'package:eventmobile/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          index: index,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          color: Colors.black87,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
          items: const [
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.search,
              size: 30,
            ),
            Icon(
              Icons.person,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
