import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sidebar.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late final SupabaseClient supabaseClient;
  final TextEditingController _messageController = TextEditingController();
  final String userId =
      "1dad0d0a-09bf-4d70-a1e0-cca170309a78"; // Replace with actual user ID
  final String doctorId = "870a7d21-d982-41ba-a780-884a58f0fe5d";

  bool? get kDebugMode => null; // Replace with actual doctor ID

  @override
  void initState() {
    super.initState();
    supabaseClient = Supabase.instance.client;
    fetchMessages();
  }

  // Send Message Function
  Future<void> sendMessage() async {
    final message = _messageController.text;

    if (message.isEmpty) return;

    final response = await supabaseClient.from('messages').insert({
      'message': message,
      'sender_id': userId,
      'receiver_id': doctorId,
    }); // Correct method call for the latest SDK

    // Handle error and data correctly
    if (response.error != null) {
      print("Error: ${response.error!.message}");
      return;
    }

    print("Message sent: ${response.data}");

    setState(() {
      _messageController.clear();
    });

    fetchMessages();
  }

  // Fetch Messages Function
  Future<void> fetchMessages() async {
    final response = await supabaseClient
        .from('messages')
        .select()
        .eq('sender_id', doctorId)
        .eq('receiver_id', userId)
        .order('created_at', ascending: true)
        .limit(20);
    // Use execute to get response

    // Handle error and data correctly
    if (response.error != null) {
      if (kDebugMode != null && kDebugMode!) {}
      return;
    }

    final List messages = response.data as List;
    print("Fetched messages: $messages");

    // Process fetched messages
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('message')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Adjust based on your messages list
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Message $index'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Type your message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on PostgrestList {
  get error => null;

  get data => null;
}
