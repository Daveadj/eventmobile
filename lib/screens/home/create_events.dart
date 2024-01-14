// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:eventmobile/models/create_event_model.dart';
import 'package:eventmobile/screens/home/add_sample.dart';
import 'package:eventmobile/screens/home/components/upload_photo.dart';
import 'package:eventmobile/screens/home/provider/home_notifier.dart';
import 'package:eventmobile/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:eventmobile/screens/home/components/eventdetailsform.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends ConsumerStatefulWidget {
  const AddEvent({Key? key}) : super(key: key);
  @override
  ConsumerState<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends ConsumerState<AddEvent> {
  late GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  TextEditingController ticketNameController = TextEditingController();
  File? image;
  String? selectedTicketType;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  DateTime parseDateTime(String dateString, String timeString) {
    String combinedString = '$dateString $timeString';

    DateTime dateTime = DateFormat('yyyy-MM-dd h:mm a').parse(combinedString);

    return dateTime;
  }

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
                    onTicketTypeChanged: (String? ticketType) {
                      setState(() {
                        selectedTicketType = ticketType;
                        ticketNameController.text = selectedTicketType ?? '';
                      });
                    },
                    formKeys: formKeys,
                    titleController: titleController,
                    locationController: locationController,
                    descriptionController: descriptionController,
                    timeController: timeController,
                    dateController: dateController,
                    ticketNameController: ticketNameController,
                    priceController: priceController,
                  ),
                  UploadPhotoScreen(
                    pickImageCallback: () {
                      pickImage();
                    },
                    image: image,
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              onPressed: () async {
                if (formKeys.currentState!.validate() &&
                    image != null &&
                    selectedTicketType != null) {
                  final date =
                      parseDateTime(dateController.text, timeController.text);
                  final eventDetails = CreateEventClass(
                    description: descriptionController.text,
                    startTime: date,
                    title: titleController.text,
                    location: locationController.text,
                  );
                  final ticket = CreateTicket(
                      ticketName: ticketNameController.text,
                      price: priceController.text);
                  await ref.read(homeNotifierProvider.notifier).createEvent(
                        context,
                        eventDetails,
                        ticket,
                        image!,
                      );
                } else {
                  SnackBarHelper.showErrorSnackBar(
                      context,
                      'fill in all required details,select ticke type and upload your image',
                      false);
                }
              },
              child: Text(
                'Create Event',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
