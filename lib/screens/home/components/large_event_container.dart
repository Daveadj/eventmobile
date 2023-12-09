import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventmobile/models/event_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LargeEventContainer extends StatelessWidget {
  const LargeEventContainer({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    String formatDateTime(DateTime dateTime, String format) {
      return DateFormat(format).format(dateTime);
    }

    return Container(
      height: 220,
      width: 270,
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
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
                        formatDateTime(event.startTime, 'd MMMM h:mm a'),
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Free",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
