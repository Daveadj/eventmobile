import 'package:eventmobile/provider/auth_notifier.dart';
import 'package:eventmobile/screens/profile/components/follow_column.dart';
import 'package:eventmobile/screens/profile/profile_sample.dart';
import 'package:eventmobile/screens/profile/profile_screen.dart';
import 'package:eventmobile/screens/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _logOut(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure you want to Logout?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).logout(context);
                },
                isDefaultAction: true,
                isDestructiveAction: true,
                child: const Text('Yes'),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: false,
                isDestructiveAction: false,
                child: const Text('No'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ProfileSample(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black,
                // You can customize the avatar with an image or initials
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('PostMalone'),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FollowColumn(
                  number: '12.5M',
                  title: 'Followers',
                ),
                FollowColumn(
                  number: '12',
                  title: 'Following',
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: 'Calendar',
              onTap: () {},
            ),
            SettingsListTile(
              leading: const Icon(Icons.comment_sharp),
              title: 'Message Center',
              onTap: () {},
            ),
            const Divider(),
            SettingsListTile(
              leading: const Icon(Icons.person),
              title: 'Profile',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ProfileScreen(),
                  ),
                );
              },
            ),
            SettingsListTile(
              leading: const Icon(Icons.notifications_active),
              title: 'Notifications',
              onTap: () {},
            ),
            SettingsListTile(
              leading: const Icon(Icons.payment),
              title: 'Payments',
              onTap: () {},
            ),
            SettingsListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: 'Reminders',
              onTap: () {},
            ),
            SettingsListTile(
              leading: const Icon(Icons.privacy_tip),
              title: 'Privacy Policy',
              onTap: () {},
            ),
            SettingsListTile(
              leading: const Icon(Icons.report),
              title: 'Report',
              onTap: () {},
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: theme.isDarkMode,
              onChanged: (value) {
                final toggle = ref.read(themeProvider.notifier);
                toggle.toggleTheme(value);
              },
            ),
            SettingsListTile(
              leading: const Icon(Icons.logout),
              title: 'Logout',
              onTap: () {
                _logOut(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
  });
  final Widget leading;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
