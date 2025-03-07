import 'package:flutter/material.dart';
import 'sidebar.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String aboutText = """
    Mind Connect is a mobile application designed to provide mental health support through a variety of features, 
    including interactive chatbots, mental health resources, routines, and connections with mental health professionals. 
    The app aims to help users manage stress, anxiety, and other mental health concerns by providing accessible tools, 
    including breathing exercises, grounding techniques, and positive affirmations. With its user-friendly interface and 
    personalized support, Mind Connect strives to be a reliable companion in every user's mental wellness journey.
    """;

    return Scaffold(
      drawer: AppSidebar(),
      appBar: AppBar(title: Text("About")),
      body: SingleChildScrollView(
        // Makes the content scrollable
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Smaller container
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20), // Rounded corners
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 100),
                SizedBox(height: 20),
                Text(
                  "About Mind Connect",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  aboutText,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
