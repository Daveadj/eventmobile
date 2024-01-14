import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final String location;
  const LocationWidget({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/map.jpeg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
         Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
