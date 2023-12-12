import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventmobile/models/event_models.dart';
import 'package:eventmobile/models/ticket_models.dart';
import 'package:eventmobile/screens/home/components/location_widget.dart';
import 'package:eventmobile/screens/home/components/ticket_option_tile.dart';
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
                ),
              ),
              Container(
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
              Text(
                widget.event.description,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
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
                      'https://picsum.photos/seed/468/600',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'PostMalone',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.message,
                    ),
                  )
                ],
              ),
              const Text(
                'Post Malone will at the hmv Underground at 333 Yonge Street on March 24, 2015 at 5:00 PM for an exclusive FAN MEET & GREET. Space is limited to the first 300 fans on a first come first served basis (as per the event protocol)',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
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
                          text: 'Location',
                        ),
                        Tab(
                          text: 'Pricing',
                        )
                      ],
                    ),
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
