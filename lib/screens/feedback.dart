import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sidebar.dart';

class FeedbackPage extends StatelessWidget {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSidebar(),
      appBar: AppBar(title: Text("Feedback")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showFeedbackDialog(context);
          },
          child: Text("Give Feedback"),
        ),
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 16,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Your Feedback",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: "Write your feedback...",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await _submitFeedback(context);
                  },
                  child: Text("Send"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _submitFeedback(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final feedbackText = _feedbackController.text.trim();

    if (feedbackText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Feedback cannot be empty!")),
      );
      return;
    }

    try {
      final response = await supabase.from("feedbacks").insert({
        "feedback": feedbackText,
        "date": DateTime.now().toIso8601String(),
      });

      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Feedback submitted successfully!")),
        );
        _feedbackController.clear();
        Navigator.pop(context); // Close the dialog
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting feedback: $error")),
      );
    }
  }
}
