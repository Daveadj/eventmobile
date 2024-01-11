// ignore_for_file: use_build_context_synchronously

import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  double containerWidth = 200.0;
  @override
  void initState() {
    super.initState();
    // Initialize form keys for each page
    formKeys = List.generate(2, (index) => GlobalKey<FormState>());
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
                      (page + 2) / 3.0 * MediaQuery.of(context).size.width;
                });
              },
              children: [
                EventDetailForm(
                  pageIndex: 1,
                  formKeys: formKeys,
                  titleController: titleController,
                  locationController: locationController,
                  descriptionController: descriptionController,
                  timeController: timeController,
                  dateController: dateController,
                  ticketNameController: ticketNameController,
                  priceController: priceController,
                  availableSpaceController: availableSpaceController,
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
                Text('${currentPage + 1}/2'),
                ElevatedButton(
                  onPressed: () {
                    if (formKeys[currentPage].currentState!.validate()) {
                      if (currentPage < 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    }
                  },
                  child: Text(currentPage < 1 ? 'Next' : 'Save'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget multiLineFormField(String label, TextEditingController controller,
    String? Function(String? value) validator, BuildContext context) {
  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: TextInputType.multiline,
    maxLines: 5,
    style: TextStyle(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
    ),
    decoration: InputDecoration(
      hintStyle: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      labelStyle: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
      ),
      hintText: 'Describe your Event',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

class EventDetailForm extends StatelessWidget {
  const EventDetailForm({
    super.key,
    required this.pageIndex,
    required this.formKeys,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.timeController,
    required this.dateController,
    required this.ticketNameController,
    required this.priceController,
    required this.availableSpaceController,
  });
  final int pageIndex;
  final List<GlobalKey<FormState>> formKeys;
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final TextEditingController dateController;
  final TextEditingController ticketNameController;
  final TextEditingController priceController;
  final TextEditingController availableSpaceController;
  String? titleValidator(String? value) {
    if (value!.isEmpty) {
      return 'Enter Title';
    } else if (value.length < 5 || value.length > 20) {
      return 'Title Length should be between 5 to 20 characters';
    } else {
      return null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != dateController.text) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      timeController.text = pickedTime.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeys[pageIndex - 1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Event details',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: InputFormField(
                  validator: titleValidator,
                  label: 'Event Name',
                  hintText: 'Event Name',
                  obscureText: false,
                  controller: titleController,
                ),
              ),
              SizedBox(
                width: 180,
                child: InputFormField(
                  validator: titleValidator,
                  label: 'Event Name',
                  hintText: 'Event Name',
                  obscureText: false,
                  controller: titleController,
                ),
              )
            ],
          ),
          multiLineFormField(
            'Describe your Event',
            descriptionController,
            titleValidator,
            context
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: InputFormField(
                  validator: titleValidator,
                  label: 'Event Date',
                  hintText: 'Event Date',
                  ontap: () {
                    _selectDate(context);
                  },
                  readonly: true,
                  obscureText: false,
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                  ),
                  controller: dateController,
                ),
              ),
              SizedBox(
                width: 180,
                child: InputFormField(
                  validator: titleValidator,
                  label: 'Event Time',
                  hintText: 'Event Time',
                  ontap: () {
                    _selectTime(context);
                  },
                  readonly: true,
                  obscureText: false,
                  suffixIcon: const Icon(
                    Icons.alarm,
                  ),
                  controller: timeController,
                ),
              )
            ],
          ),
          const Text('Ticket Details'),
          Row(
            children: [
              SizedBox(
                width: 180,
                child: InputFormField(
                  validator: (value) {},
                  label: 'Ticket Type',
                  hintText: 'Ticket Type',
                  obscureText: false,
                  controller: availableSpaceController,
                ),
              ),
              SizedBox(
                width: 180,
                child: InputFormField(
                  validator: (value) {},
                  label: 'Event Time',
                  hintText: 'Event Time',
                  ontap: () {},
                  readonly: true,
                  obscureText: false,
                  controller: priceController,
                ),
              )
            ],
          ),
          InputFormField(
            validator: (value) {},
            label: 'Avalable Space',
            hintText: 'Avalable Name',
            obscureText: false,
            controller: ticketNameController,
          ),
          // Add more form fields as needed
        ],
      ),
    );
  }
}
