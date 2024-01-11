// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:eventmobile/screens/home/components/eventdetailsform.dart';
import 'package:flutter/material.dart';

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
                  const UploadPhotoScreem()
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
              onPressed: () {
                if (formKeys.currentState!.validate()) {}
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

class UploadPhotoScreem extends StatefulWidget {
  const UploadPhotoScreem({super.key});

  @override
  State<UploadPhotoScreem> createState() => _UploadPhotoScreemState();
}

class _UploadPhotoScreemState extends State<UploadPhotoScreem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          strokeWidth: 1,
          borderType: BorderType.Rect,
          dashPattern: const [8, 8],
          child: const SizedBox(
            height: 250,
            width: 350,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload,
                    size: 100,
                  ),
                  Text(
                    'Upload your file',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              backgroundColor: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_library,
                  size: 24.0,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
