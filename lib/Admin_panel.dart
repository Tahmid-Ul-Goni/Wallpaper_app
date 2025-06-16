import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future uploadImage() async {
    if (_image == null) return;

    // Upload to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
    FirebaseStorage.instance.ref().child("wallpapers/$fileName.jpg");
    UploadTask uploadTask = storageRef.putFile(_image!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    // Save URL in Firestore
    await FirebaseFirestore.instance.collection("wallpapers").add({
      "image_url": downloadURL,
      "timestamp": FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload Successful! ✅")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel")),
      body: Column(
        children: [
          _image != null
              ? Image.file(_image!, height: 200)
              : Text("No Image Selected"),
          ElevatedButton(onPressed: pickImage, child: Text("Pick Image")),
          ElevatedButton(onPressed: uploadImage, child: Text("Upload")),
        ],
      ),
    );
  }
}