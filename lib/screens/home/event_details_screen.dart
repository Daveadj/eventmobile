import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventmobile/models/event_models.dart';
import 'package:eventmobile/models/ticket_models.dart';

import 'package:eventmobile/screens/home/comment_screen.dart';
import 'package:eventmobile/screens/home/components/location_widget.dart';
import 'package:eventmobile/screens/home/components/ticket_option_tile.dart';
import 'package:eventmobile/screens/profile/other_users_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.event});

  final Event event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.event.image,
                      width: double.infinity,
                      height: 320,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      widget.event.description,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return const CommentScreen();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.message,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2023/09/14/15/54/bird-8253245_1280.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const OtherUserProfileScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'PostMalone',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      formatDateTime(widget.event.startTime),
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Post Malone will at the hmv Underground at 333 Yonge Street on March 24, 2015 at 5:00 PM for an exclusive FAN MEET & GREET. Space is limited to the first 300 fans on a first come first served basis (as per the event protocol)',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  height: 45,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      fontFamily: 'lato',
                      fontSize: 17,
                    ),
                    tabs: [
                      Tab(
                        text: 'Location',
                      ),
                      Tab(
                        text: 'Pricing',
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const LocationWidget(),
                    ListView.builder(
                      itemCount: ticketOptions.length,
                      itemBuilder: (context, index) {
                        return TicketOptionTile(
                          ticketOption: ticketOptions[index],
                        );
                      },
                    ),
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
