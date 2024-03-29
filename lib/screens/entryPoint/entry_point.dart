import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventmobile/screens/home/home_screen.dart';
import 'package:eventmobile/screens/profile/other_users_profile_screen.dart';
import 'package:eventmobile/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryPoint extends ConsumerStatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  ConsumerState<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends ConsumerState<EntryPoint> {
  int index = 0;
  bool isNavBarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: index,
            children: [
              HomeScreen(
                onScroll: (isVisible) {
                  setState(() {
                    isNavBarVisible = isVisible;
                  });
                },
              ),
              const OtherUserProfileScreen(),
              const SettingsScreen(),
            ],
          ),
          if (isNavBarVisible)
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                child: CurvedNavigationBar(
                  index: index,
                  height: 65,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  color: Colors.black87,
                  backgroundColor: Colors.transparent,
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
                      Icons.settings,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
