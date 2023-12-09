import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventmobile/models/event_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Recent Events"),
              Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87, // Box shadow color
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Offset of the shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: event.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white, // Shimmer effect color
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 13,
                      right: 13,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.description,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.black,
                                ),
                                Text(
                                  formatDateTime(
                                      event.startTime, 'd MMMM h:mm a'),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "Free",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text('Events'),
                  const Spacer(),
                  GestureDetector(
                    child: const Text(
                      'View all',
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                ],
              ),
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width / 1.05,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87, // Box shadow color
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Offset of the shadow
                    ),
                  ],
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      35,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: event.image,
                        height: 140,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white, // Shimmer effect color
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 170,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        color: Colors.white.withOpacity(0.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.description,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
                              Text(
                                formatDateTime(
                                    event.startTime, 'd MMMM h:mm a'),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                "Free",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
