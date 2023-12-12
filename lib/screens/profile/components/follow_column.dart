


import 'package:flutter/material.dart';

class FollowColumn extends StatelessWidget {
  const FollowColumn({
    super.key,
    required this.number,
    required this.title,
  });
  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Lato',
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
