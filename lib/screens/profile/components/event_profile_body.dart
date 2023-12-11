

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventProfileBody extends StatelessWidget {
  const EventProfileBody({super.key});
  String formattedDateTime(DateTime dateTime) {
    return DateFormat('E\nd\nyyyy').format(
        dateTime); // 'E' for abbreviated day name, 'd' for day of the month
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(
            formattedDateTime(
              DateTime.now(),
            ),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          title: const Text(
            'Billboard Concert',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: const Text(
            'New York City',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            size: 20,
          ),
        ),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }
}
