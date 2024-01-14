

import 'package:eventmobile/models/events.model.dart';
import 'package:flutter/material.dart';

class TicketOptionTile extends StatelessWidget {
  final Ticket ticket;

  const TicketOptionTile({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticket.ticketName),
      subtitle: Text('\$${ticket.price.toStringAsFixed(2)}'),
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ),
    );
  }
}
