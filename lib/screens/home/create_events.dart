// ignore_for_file: use_build_context_synchronously

import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:eventmobile/screens/home/add_sample.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);
  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController availableSpaceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ticketNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Event',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(
                fontFamily: 'lato',
                fontSize: 17,
              ),
              tabs: [
                Tab(
                  text: 'Event Details',
                ),
                Tab(
                  text: 'Add Photo',
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  EventDetailedForm(
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
                  Container()
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (formKeys.currentState!.validate()) {}
            },
            child: const Text('Create Event'),
          ),
        ),
      ),
    );
  }
}

class EventDetailedForm extends StatelessWidget {
  const EventDetailedForm({
    super.key,
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

  final GlobalKey<FormState> formKeys;
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
      key: formKeys,
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
          InputFormField(
            validator: (value) {},
            label: 'Avalable Space',
            hintText: 'Avalable Name',
            obscureText: false,
            controller: ticketNameController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

          // Add more form fields as needed
        ],
      ),
    );
  }
}
