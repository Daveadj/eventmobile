import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
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
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.location_on,
                  size: 60,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'New York city',
                  style: TextStyle(
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
