// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:eventmobile/screens/Auth/login_screen.dart';
import 'package:eventmobile/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
    required this.onTicketTypeChanged,
  });

  final GlobalKey<FormState> formKeys;
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final TextEditingController timeController;
  final TextEditingController dateController;
  final TextEditingController ticketNameController;
  final TextEditingController priceController;
  final Function(String? ticketType) onTicketTypeChanged;

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
    String? selectedTicketType;
    return Form(
      key: formKeys,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Event details',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: InputFormField(
                      validator: (String? value) {
                        return Validator.titleValidator(
                            value!, 5, 20, 'Event Name');
                      },
                      label: 'Event Name',
                      hintText: 'Event Name',
                      obscureText: false,
                      controller: titleController,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: InputFormField(
                      validator: (String? value) {
                        return Validator.titleValidator(
                            value!, 3, 30, 'Event Location');
                      },
                      label: 'Event Location',
                      hintText: 'Event Location',
                      obscureText: false,
                      controller: locationController,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              multiLineFormField('Describe your Event', descriptionController,
                  (String? value) {
                return Validator.titleValidator(
                    value!, 20, 200, 'Event Description');
              }, context),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: InputFormField(
                      validator: (String? value) {
                        return Validator.titleValidator(
                            value!, 3, 20, 'Event Date');
                      },
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
                      validator: (String? value) {
                        return Validator.titleValidator(
                            value!, 3, 20, 'Event Time');
                      },
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Ticket Details',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    child: DropdownButtonFormField<String>(
                      value: selectedTicketType,
                      onChanged: (String? newValue) {
                        selectedTicketType = newValue;

                        onTicketTypeChanged(selectedTicketType);
                        if (selectedTicketType == 'Free') {
                          priceController.text = '0.0';
                        } else if (selectedTicketType == null) {
                          priceController.text = 'Select Ticket Type';
                        } else {
                          priceController.text = '';
                        }
                      },
                      items: [null, 'Free', 'Paid']
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value ?? 'Select Ticket Type'),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Ticket Type',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: InputFormField(
                      validator: (String? value) {
                        return Validator.titleValidator(value!, 1, 20, 'Price');
                      },
                      label: 'Price',
                      hintText: 'Price',
                      obscureText: false,
                      controller: priceController,
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}$')),
                      ],
                      readonly: priceController.text == '0.0' ||
                          priceController.text == 'Select Ticket Type',
                    ),
                  )
                ],
              ),

              // Add more form fields as needed
            ],
          ),
        ),
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
