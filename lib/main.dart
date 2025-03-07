// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mind_connect/screens/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './screens/login.dart';
import './screens/register.dart';
import './screens/chat.dart';
import './screens/doctors_list.dart';
import './screens/doctor_preview.dart';
import './screens/feedback.dart';
// ignore: unused_import
import './screens/sidebar.dart';
import './screens/resources.dart';
import './screens/routine.dart';
import './screens/about.dart';
import './screens/home.dart';

import './screens/message.dart';
import './screens/appointment_screen.dart';
import './screens/call_screen.dart';
import './screens/video_call_screen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bzdczktvzkedsptxojrw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6ZGN6a3R2emtlZHNwdHhvanJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA5OTQ3NjksImV4cCI6MjA1NjU3MDc2OX0.RzCWvFmyrpL6JiFC-Lno8ozryekHJOSeRxnhjhKVh9g',
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/login",
    routes: {
      "/login": (context) => LoginPage(),
      "/register": (context) => RegisterPage(),
      "/home": (context) => HomePage(),
      "/chat": (context) => ChatPage(),
      '/doctors_list': (context) => DoctorsListPage(),
      "/doctorPreview": (context) => DoctorPreviewPage(),
      "/feedback": (context) => FeedbackPage(),
      "/profile": (context) => ProfilePage(),
      "/resources": (context) => ResourcesPage(),
      "/routine": (context) => RoutinePage(),
      "/about": (context) => AboutPage(),
      '/chatScreen': (context) => Message(),
      '/appointmentBooking': (context) => AppointmentScreen(),
      '/callScreen': (context) => CallScreen(),
      '/videoCallScreen': (context) => VideoCallScreen(),
    },
  ));
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image. Please try again.")),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.camera_alt, size: 50) : null,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String email = _emailController.text;

                print("Saving: Name: $name, Email: $email, Image: $_image");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profile updated (mock)")),
                );
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
