import 'package:eventmobile/screens/profile/components/follow_column.dart';
import 'package:eventmobile/screens/profile/profile_sample.dart';
import 'package:eventmobile/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
            SettingsListTile(
              leading: const Icon(Icons.logout),
              title: 'Logout',
              onTap: () {},
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
