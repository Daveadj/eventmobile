import 'package:eventmobile/screens/profile/components/event_profile_body.dart';
import 'package:eventmobile/screens/profile/components/follow_column.dart';
import 'package:eventmobile/screens/profile/components/my_delegate.dart';
import 'package:eventmobile/screens/profile/components/post_body.dart';
import 'package:flutter/material.dart';

class ProfileSample extends StatefulWidget {
  const ProfileSample({super.key});

  @override
  State<ProfileSample> createState() => _ProfileSampleState();
}

class _ProfileSampleState extends State<ProfileSample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                collapsedHeight: 250,
                expandedHeight: 250,
                flexibleSpace: Column(
                  children: [
                    ProfileHeader(),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      fontFamily: 'lato',
                      fontSize: 17,
                    ),
                    tabs: [
                      Tab(
                        text: 'Post',
                      ),
                      Tab(
                        text: 'Events',
                      )
                    ],
                  ),
                ),
                pinned: true,
                floating: true,
              )
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return PostBody();
                },
              ),
              EventProfileBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            // Positioned(
            //   top: 40,
            //   left: 10,
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: const Icon(
            //       Icons.arrow_back,
            //       size: 30,
            //     ),
            //   ),
            // ),
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
      ],
    );
  }
}
