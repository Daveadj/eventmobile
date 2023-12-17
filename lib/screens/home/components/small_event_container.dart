import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventmobile/models/event_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class SmallEventContainer extends StatelessWidget {
  const SmallEventContainer({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    String formatDateTime(DateTime dateTime, String format) {
      return DateFormat(format).format(dateTime);
    }

    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width / 1.05,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black87, // Box shadow color
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: Offset(0, 3), // Offset of the shadow
        //   ),
        // ],

        borderRadius: const BorderRadius.all(
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
              width: 130,
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
          Container(
            height: 170,
            width: 170,
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
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                    ),
                    Text(
                      formatDateTime(event.startTime, 'd MMMM h:mm a'),
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Free",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
