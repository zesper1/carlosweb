import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doctor =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(title: Text("Video Call with ${doctor?['name']}")),
      body: Center(
        child: Text("Video call feature will be implemented here."),
      ),
    );
  }
}
