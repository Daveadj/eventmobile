import 'package:eventmobile/screens/profile/components/event_profile_body.dart';
import 'package:eventmobile/screens/profile/components/follow_column.dart';
import 'package:eventmobile/screens/profile/components/post_body.dart';
import 'package:eventmobile/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String formattedDateTime(DateTime dateTime) {
    return DateFormat('E\nd\nyyyy').format(
        dateTime); // 'E' for abbreviated day name, 'd' for day of the month
  }

  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(
                        30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                          // You can customize the avatar with an image or initials
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'PostMalone',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FollowColumn(
                  number: '99',
                  title: 'Events',
                ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: const TextStyle(
                    fontFamily: 'lato',
                    fontSize: 17,
                  ),
                  indicator: BoxDecoration(
                    color: Colors.blue, // Set the indicator color
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  tabs: const [
                    Tab(
                      text: 'Post',
                    ),
                    Tab(
                      text: 'Events',
                    )
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  PostBody(),
                  EventProfileBody(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
