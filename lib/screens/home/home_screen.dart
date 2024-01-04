import 'package:eventmobile/models/event_models.dart';
import 'package:eventmobile/screens/home/components/large_event_container.dart';
import 'package:eventmobile/screens/home/components/search_container.dart';
import 'package:eventmobile/screens/home/components/shimmer_container.dart';
import 'package:eventmobile/screens/home/components/small_event_container.dart';
import 'package:eventmobile/screens/home/event_details_screen.dart';
import 'package:eventmobile/screens/home/provider/home_notifier.dart';
import 'package:eventmobile/screens/search/search_screen.dart';
import 'package:eventmobile/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Function(bool) onScroll;

  const HomeScreen({Key? key, required this.onScroll}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isNavBarVisible = true;
  String username = '';
  late Future<void> allEventFuture;
  @override
  void initState() {
    allEventFuture = ref.read(homeNotifierProvider).fetchEvent(context);
    getUsername();
    super.initState();
  }

  Future<void> getUsername() async {
    var result = await UserStorage.getUserName();
    setState(() {
      username = result!;
    });
  }

  String getTimeOfDay() {
    final currentTime = DateTime.now().hour;

    if (currentTime < 12) {
      return 'Morning';
    } else if (currentTime < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    var newEvent = ref.watch(homeNotifierProvider).events;
    var recentEvents = ref.watch(homeNotifierProvider).recentEvents;
    var day = getTimeOfDay();
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
                  collapsedHeight: recentEvents.isEmpty ? 83 : 330,
                  expandedHeight: recentEvents.isEmpty ? 0 : 330,
                  flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good $day',
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  username,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: MySearchDelegate(),
                                );
                              },
                              child: const SearchContainer(),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.add_circle_outline,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      recentEvents.isEmpty
                          ? Container()
                          : const Padding(
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
                      recentEvents.isEmpty
                          ? Container()
                          : SingleChildScrollView(
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
            body: FutureBuilder(
              future: allEventFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ShimmerSmallEventContainer(),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return (newEvent.isEmpty)
                      ? const Center(
                          child: Text(
                            'No event',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                itemCount: newEvent.length,
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
                                        event: newEvent[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
