import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doctor =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(title: Text("Calling ${doctor?['name']}")),
      body: Center(
        child: Text("Call feature will be implemented here."),
      ),
    );
  }
}
