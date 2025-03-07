import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'sidebar.dart';

class RoutinePage extends StatefulWidget {
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  FlutterTts flutterTts = FlutterTts();

  final List<Map<String, String>> exercises = [
    {
      'title': 'Deep Breathing',
      'image': 'assets/image4.jpg',
      'description':
          'Deep breathing helps to relax your body and mind, reducing stress and anxiety.'
    },
    {
      'title': 'Meditation',
      'image': 'assets/image3.jpg',
      'description':
          'Meditation helps improve focus, self-awareness, and emotional balance.'
    },
    {
      'title': 'Journaling',
      'image': 'assets/image2.jpg',
      'description':
          'Writing down your thoughts and emotions can help you process your feelings effectively.'
    },
    {
      'title': 'Gratitude Practice',
      'image': 'assets/image1.jpg',
      'description':
          'Listing things you are grateful for helps increase positivity and well-being.'
    },
    {
      'title': 'Physical Exercise',
      'image': 'assets/image.jpg',
      'description':
          'Regular physical activity boosts mood and reduces stress and anxiety.'
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  // Function to read the text aloud
  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  // Function to stop the text-to-speech
  Future<void> _stop() async {
    await flutterTts.stop();
  }

  // Show exercise details with the option to listen
  void showExerciseDetails(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(description),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _speak(description),
              icon: Icon(Icons.volume_up),
              label: Text('Listen'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSidebar(),
      appBar: AppBar(title: Text("Mental Health Routine")),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.accessibility, size: 100),
                SizedBox(height: 10),
                Text(
                  "Mental Health Routine",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => showExerciseDetails(
                        context,
                        exercises[index]['title']!,
                        exercises[index]['description']!,
                      ),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  exercises[index]['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                exercises[index]['title']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _speak(
                            exercises.map((e) => e['description']).join('\n'));
                      },
                      child: Text("Listen to Routine"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _stop();
                      },
                      child: Text("Stop"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
