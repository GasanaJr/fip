// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  File? _image;

  // Method to open the camera
  Future<void> _openCamera() async {
    final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.camera);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report an Issue'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _image == null
                          ? Text('No Image Selected')
                          : Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: _openCamera,
                        icon: Icon(
                          Icons.camera_alt,
                          size: 50,
                        ),
                        tooltip: "Open Camera",
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter the site of the issue",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Level of Damage",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Select level of damage",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "low",
                          child: Text("Low"),
                        ),
                        DropdownMenuItem(
                          value: "medium",
                          child: Text("Medium"),
                        ),
                        DropdownMenuItem(
                          value: "high",
                          child: Text("High"),
                        ),
                      ],
                      onChanged: (String? newValue) {},
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: "Please Describe the Issue",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 10),
                    child: Text(
                      "Priority",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Please select the priority of the issue",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: "1", child: Text("1 - Lowest")),
                      DropdownMenuItem(value: "2", child: Text("2")),
                      DropdownMenuItem(value: "3", child: Text("3")),
                      DropdownMenuItem(value: "4", child: Text("4")),
                      DropdownMenuItem(value: "5", child: Text("5 - Highest")),
                    ],
                    onChanged: (String? newValue) {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "*Verify the whole information before reporting",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color(0xFF143342)),
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.white),
                              textStyle: MaterialStatePropertyAll<TextStyle>(
                                  TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              minimumSize:
                                  MaterialStatePropertyAll<Size>(Size(150, 50)),
                            ),
                            child: Text("Report"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
