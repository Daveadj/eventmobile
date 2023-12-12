

import 'package:eventmobile/models/ticket_models.dart';
import 'package:flutter/material.dart';

class TicketOptionTile extends StatelessWidget {
  final TicketOption ticketOption;

  const TicketOptionTile({super.key, required this.ticketOption});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticketOption.name),
      subtitle: Text('\$${ticketOption.price.toStringAsFixed(2)}'),
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ),
    );
  }
}
