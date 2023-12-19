import 'package:eventmobile/screens/entryPoint/entry_point.dart';
import 'package:eventmobile/screens/home/home_screen.dart';
import 'package:eventmobile/screens/onboarding.dart';
import 'package:eventmobile/screens/settings/settings_screen.dart';
import 'package:eventmobile/screens/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/main.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: theme.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: child,
        );
      },
      child: const OnboardingScreen(),
    );
  }
}
