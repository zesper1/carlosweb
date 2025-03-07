import 'package:flutter/material.dart';
import 'sidebar.dart';

class ResourcesPage extends StatelessWidget {
  // Function to show the emergency hotlines popup
  void _showEmergencyHotlines(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Emergency Hotlines"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Hopeline: (02) 804-4673 (Landline), 0917-558-4673 (Globe)"),
                SizedBox(height: 10),
                Text(
                    "Tawag Paglaum – Centro Bisaya: 0966-467-9626 (Globe and TM)"),
                SizedBox(height: 10),
                Text("NCMH Crisis Hotline: (02) 1553 (Luzon landline)"),
                SizedBox(height: 10),
                Text("Manila Lifeline Centre: (02) 896-9191 (Landline)"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSidebar(),
      appBar: AppBar(title: Text("Resources")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.phone, size: 100),
            SizedBox(height: 10),
            Text(
              "Emergency Hotlines",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showEmergencyHotlines(
                    context); // Show the emergency hotlines popup
              },
              child: Text("Show Emergency Hotlines"),
            ),
          ],
        ),
      ),
    );
  }
}
