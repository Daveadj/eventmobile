import 'package:eventmobile/models/event_models.dart';
import 'package:eventmobile/screens/home/components/large_event_container.dart';
import 'package:eventmobile/screens/home/components/small_event_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  var event = Event(
    description: "What's up abuja gdgsdgugdd wduhudwhdwhd",
    image:
        "https://img.freepik.com/free-photo/happy-birthday-party-drinking-champagne_23-2148757436.jpg",
    id: 2,
    startTime: DateTime.now(),
    endTime: DateTime.now().add(
      const Duration(days: 1),
    ),
  );
  String formatDateTime(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const Text(
                "Recent Events",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              LargeEventContainer(event: event),
              Row(
                children: [
                  const Text(
                    'Events',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SmallEventContainer(event: event),
            ],
          ),
        ),
      ),
    );
  }
}
