// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  File? _image;
  String? _location;
  String? _levelOfDamage;
  String? _description;
  String? _priority;

  final _formKey = GlobalKey<FormState>();

  // Method to open the image picker
  Future<void> _openImagePicker(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _reportIssue(BuildContext context) async {
    if (_formKey.currentState!.validate() && _image != null) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        // File upload to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('issue_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await storageRef.putFile(_image!);
        final imageUrl = await storageRef.getDownloadURL();

        // Save issue to Firestore
        await FirebaseFirestore.instance.collection('issues').add({
          'location': _location,
          'levelOfDamage': _levelOfDamage,
          'description': _description,
          'priority': _priority,
          'imageUrl': imageUrl,
          'progress': 'Not Started',
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Clear the form
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _location = null;
          _levelOfDamage = null;
          _description = null;
          _priority = null;
        });

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Issue reported successfully!')),
        );
      } catch (e) {
        Navigator.pop(context);
        print("Error reporting issue: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to report issue: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF143342),
          title: Text(
            "Report an Issue",
            style: TextStyle(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image == null
                              ? Text('No Image Selected')
                              : Container(
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.4,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            onPressed: () =>
                                _openImagePicker(ImageSource.camera),
                            icon: Icon(
                              Icons.camera_alt,
                              size: 50,
                            ),
                            tooltip: "Open Camera",
                          ),
                          IconButton(
                            onPressed: () =>
                                _openImagePicker(ImageSource.gallery),
                            icon: Icon(
                              Icons.photo_library,
                              size: 50,
                            ),
                            tooltip: "Open Gallery",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter the site of the issue",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                        onChanged: (value) => _location = value,
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a level of damage';
                          }
                          return null;
                        },
                        onChanged: (String? newValue) {
                          _levelOfDamage = newValue;
                        },
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
                    TextFormField(
                      minLines: 3,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Please Describe the Issue",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onChanged: (value) => _description = value,
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
                        DropdownMenuItem(
                            value: "5", child: Text("5 - Highest")),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a priority';
                        }
                        return null;
                      },
                      onChanged: (String? newValue) {
                        _priority = newValue;
                      },
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
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool? confirmSubmission = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Confirm Submission"),
                                      content: Text(
                                          "You are about to submit an issue"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text("Submit"),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirmSubmission == true) {
                                    await _reportIssue(context);
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color(0xFF143342)),
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                                textStyle: MaterialStatePropertyAll<TextStyle>(
                                    TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(150, 50)),
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
          ),
        ],
      ),
    );
  }
}
