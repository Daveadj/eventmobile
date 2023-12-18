import 'package:eventmobile/models/event_models.dart';
import 'package:eventmobile/screens/home/components/large_event_container.dart';
import 'package:eventmobile/screens/home/components/small_event_container.dart';
import 'package:eventmobile/screens/home/event_details_screen.dart';
import 'package:eventmobile/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onScroll;

  const HomeScreen({Key? key, required this.onScroll}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  var event = Event(
    description: "What's up abuja gdgsdgugdd wduhudwhdwhd",
    image:
        "https://img.freepik.com/free-photo/happy-birthday-party-drinking-champagne_23-2148757436.jpg",
    id: 2,
    startTime: DateTime.now(),
    endTime: DateTime.now().add(
      const Duration(days: 1),
    ),
  );

  String formatDateTime(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  bool isNavBarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              final isScrollingDown = scrollNotification.scrollDelta! > 0;
              widget.onScroll(!isScrollingDown);
            }
            return false;
          },
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  collapsedHeight: 330,
                  expandedHeight: 330,
                  flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ));
                        },
                        child: const SearchContainer(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Recent Events",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            events.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => EventDetails(
                                        event: events[index],
                                      ),
                                    ),
                                  );
                                },
                                child: LargeEventContainer(
                                  event: events[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ];
            },
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Events',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 14),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => EventDetails(
                                  event: events[index],
                                ),
                              ),
                            );
                          },
                          child: SmallEventContainer(
                            event: events[index],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
