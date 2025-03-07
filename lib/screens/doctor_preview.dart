import 'package:flutter/material.dart';
import 'sidebar.dart';

class DoctorPreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieving the doctor data passed as arguments
    final doctor =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (doctor == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Doctor Profile")),
        body: Center(child: Text("No doctor details available.")),
      );
    }

    return Scaffold(
      drawer: AppSidebar(), // Sidebar for navigation
      appBar: AppBar(
        title: Text("${doctor['name'] ?? 'Unknown'}'s Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Doctor's picture (fallback to a placeholder if null)
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: doctor["picture"] != null &&
                            doctor["picture"]!.isNotEmpty
                        ? NetworkImage(doctor["picture"]!)
                        : AssetImage("assets/placeholder.png") as ImageProvider,
                  ),
                  SizedBox(height: 20),

                  // Doctor's name
                  Text(
                    doctor["name"] ?? "Unknown Name",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),

                  // Doctor's contact number
                  Text(
                    "📞 ${doctor["cp_number"] ?? "Not Available"}",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),

                  // Doctor's email
                  Text(
                    "📧 ${doctor["email"] ?? "Not Available"}",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),

                  // Doctor's location
                  Text(
                    "📍 ${doctor["location"] ?? "Not Available"}",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Doctor's open hours
                  Text(
                    "⏰ Open Hours: ${doctor["open_hours"] ?? "Not Available"}",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
