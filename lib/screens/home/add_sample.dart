import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  PageController pageController = PageController();
  late List<GlobalKey<FormState>> formKeys;
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController availableSpaceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ticketNameController = TextEditingController();
  int currentPage = 0;
  double containerWidth = 0.0;
  @override
  void initState() {
    super.initState();
    // Initialize form keys for each page
    formKeys = List.generate(3, (index) => GlobalKey<FormState>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Event',
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 10.0,
            width: containerWidth,
            color: Colors.blue,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                  containerWidth =
                      (page + 1) / 3.0 * MediaQuery.of(context).size.width;
                });
              },
              children: [
                Column(
                  children: [
                    const Text(
                      'Event details',
                    ),
                    EventDetailForm(
                      pageIndex: 1,
                      formKeys: formKeys,
                      titleController: titleController,
                      locationController: locationController,
                      descriptionController: descriptionController,
                      timeController: timeController,
                      dateController: dateController,
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text('Ticket Details'),
                    TicketDetailsForm(
                        ticketNameController: ticketNameController,
                        priceController: priceController,
                        availableSpaceController: availableSpaceController,
                        pageIndex: 2,
                        formKeys: formKeys)
                  ],
                ),
                Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentPage > 0
                      ? () {
                          if (currentPage > 0) {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        }
                      : null,
                  child: const Text('Previous'),
                ),
                Text('${currentPage + 1}/3'),
                ElevatedButton(
                  onPressed: () {
                    if (formKeys[currentPage].currentState!.validate()) {
                      if (currentPage < 2) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    }
                  },
                  child: Text(currentPage < 2 ? 'Next' : 'Save'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EventDetailForm extends StatefulWidget {
  const EventDetailForm(
      {super.key,
      required this.pageIndex,
      required this.formKeys,
      required this.titleController,
      required this.locationController,
      required this.descriptionController,
      required this.timeController,
      required this.dateController});
  final int pageIndex;
  final List<GlobalKey<FormState>> formKeys;
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final TextEditingController dateController;
  @override
  State<EventDetailForm> createState() => _EventDetailFormState();
}

class _EventDetailFormState extends State<EventDetailForm> {
  String? titleValidator(String? value) {
    if (value!.isEmpty) {
      return 'Enter Title';
    } else if (value.length < 5 || value.length > 20) {
      return 'Title Length should be between 5 to 20 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKeys[widget.pageIndex - 1],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [],
            ),

            Row(
              children: [],
            ),
            // Add more form fields as needed
          ],
        ),
      ),
    );
  }
}

class TicketDetailsForm extends StatefulWidget {
  const TicketDetailsForm(
      {super.key,
      required this.ticketNameController,
      required this.priceController,
      required this.availableSpaceController,
      required this.pageIndex,
      required this.formKeys});
  final TextEditingController ticketNameController;
  final TextEditingController priceController;
  final TextEditingController availableSpaceController;
  final int pageIndex;
  final List<GlobalKey<FormState>> formKeys;

  @override
  State<TicketDetailsForm> createState() => _TicketDetailsFormState();
}

class _TicketDetailsFormState extends State<TicketDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKeys[widget.pageIndex - 1],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [],
            ),

            // Add more form fields as needed
          ],
        ),
      ),
    );
  }
}
