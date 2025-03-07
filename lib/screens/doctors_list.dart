import 'package:flutter/material.dart';
import 'sidebar.dart';

class DoctorsListPage extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Smith",
      "specialty": "Psychiatrist",
      "details": "Expert in depression treatment"
    },
    {
      "name": "Dr. Johnson",
      "specialty": "Psychologist",
      "details": "Focuses on cognitive therapy"
    },
    {
      "name": "Dr. Brown",
      "specialty": "Neurologist",
      "details": "Specializes in neuro disorders"
    },
    {
      "name": "Dr. Green",
      "specialty": "Therapist",
      "details": "Works on anxiety and stress"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSidebar(), // Sidebar for navigation
      appBar: AppBar(title: Text("Doctors List")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two tiles per row
            crossAxisSpacing: 10, // Space between tiles
            mainAxisSpacing: 10, // Space between tiles
          ),
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/doctorPreview',
                  arguments: doctors[index],
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      doctors[index]["name"]!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      doctors[index]["specialty"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      doctors[index]["details"]!,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.blue),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/message', // Navigates to message screen
                              arguments: doctors[index],
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today, color: Colors.green),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/appointmentScreen', // Navigates to appointment screen
                              arguments: doctors[index],
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.call, color: Colors.orange),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/callScreen', // Navigates to call screen
                              arguments: doctors[index],
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.video_call, color: Colors.red),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/videoCallScreen', // Navigates to video call screen
                              arguments: doctors[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
