// ignore_for_file: unused_import

import 'package:eventmobile/logging.dart';
import 'package:eventmobile/screens/Auth/provider/auth_notifier.dart';
import 'package:eventmobile/screens/entryPoint/entry_point.dart';
import 'package:eventmobile/screens/onboarding.dart';
import 'package:eventmobile/screens/settings/settings_screen.dart';
import 'package:eventmobile/screens/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ref.watch(themeProvider).themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const StartUpScreen(),
        );
      },
      child: const OnboardingScreen(),
    );
  }
}

class StartUpScreen extends ConsumerWidget {
  const StartUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: ref.read(authNotifierProvider.notifier).isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state while checking if the user is logged in
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            // ignore: sized_box_for_whitespace
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error
          return const Text('Error checking login status');
        } else {
          // Check if the user is logged in
          final bool isLoggedIn = snapshot.data ?? false;

          // Navigate to the appropriate screen
          if (isLoggedIn) {
            Log.i('userLoggedIn: true');
            return const EntryPoint();
          } else {
            Log.i('userLoggedIn: false');
            return const OnboardingScreen();
          }
        }
      },
    );
  }
}
