// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadPhotoScreen extends StatelessWidget {
  File? image;
  final Function() pickImageCallback;
  UploadPhotoScreen({
    Key? key,
    this.image,
    required this.pickImageCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DottedBorder(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          strokeWidth: 1,
          borderType: BorderType.Rect,
          dashPattern: const [8, 8],
          child: SizedBox(
            height: 250,
            width: 350,
            child: Center(
              child: image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.cover,
                    )
                  : const Column(
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
            onPressed: () {
              pickImageCallback();
              image = image;
            },
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
