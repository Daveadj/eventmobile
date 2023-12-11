import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  height: 200,
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 110,
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
              height: 50,
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
            Expanded(
                child: TabBarView(
              children: [
                Text(
                  'No Post available',
                ),
                Text(
                  'No event available',
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class PostAndEventToggleButton extends StatelessWidget {
  const PostAndEventToggleButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isSelected,
  });

  final Function() onPressed;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isSelected ? const Color.fromARGB(255, 6, 86, 151) : Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'lato',
            fontSize: 17,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class FollowColumn extends StatelessWidget {
  const FollowColumn({
    super.key,
    required this.number,
    required this.title,
  });
  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Lato',
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
