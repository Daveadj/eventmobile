import 'package:eventmobile/screens/profile/components/event_profile_body.dart';
import 'package:eventmobile/screens/profile/components/follow_column.dart';
import 'package:eventmobile/screens/profile/components/post_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({super.key});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
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
                const Positioned(
                  bottom: -80,
                  left: -280,
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
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40.0, // Adjust the size of the circle as needed
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .black, // Change the color of the border as needed
                          width: 2.0,
                        ),
                        shape: BoxShape.circle,
                        color: Colors
                            .white, // Change the color of the circle as needed
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.mail,
                          color: Colors
                              .black, // Change the color of the icon as needed
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
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
