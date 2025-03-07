import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // Needed to check device type
import 'sidebar.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  String apiUrl = "http://192.168.18.102:5000/chat";

  @override
  void initState() {
    super.initState();
    _setApiUrl();
  }

  /// Dynamically sets API URL based on the device type
  Future<void> _setApiUrl() async {
    try {
      if (Platform.isAndroid) {
        apiUrl = "http://10.0.2.2:5000/chat"; // Android Emulator
      } else if (Platform.isIOS) {
        apiUrl = "http://localhost:5000/chat"; // iOS Simulator
      }
      setState(() {}); // Update UI with new API URL
    } catch (e) {
      print("Error setting API URL: $e");
    }
  }

  /// Sends a message to the chatbot API
  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "message": message});
    });

    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String botResponse =
            data["response"] ?? "I'm here for you. How are you feeling today?";

        setState(() {
          _messages.add({"sender": "bot", "message": botResponse});
        });
      } else {
        _showError("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Connection error: Check API URL.");
    }
  }

  /// Displays error messages in chat and as a SnackBar
  void _showError(String message) {
    setState(() {
      _messages.add({"sender": "bot", "message": message});
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSidebar(), // Left Sidebar
      endDrawer: _chatHistorySidebar(), // Right Sidebar for chat history
      appBar: AppBar(
        title: Text("MIND CONNECT"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.history),
              onPressed: () =>
                  Scaffold.of(context).openEndDrawer(), // Opens right sidebar
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _feelingStatusWidget(), // Feeling status section
          _chatWidget(), // Chat UI section
        ],
      ),
    );
  }

  /// Feeling Status Widget
  Widget _feelingStatusWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          Text("How are you feeling today?", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              _emotionButton("😊", "I'm feeling happy 😊"),
              _emotionButton("😐", "I'm feeling okay 😐"),
              _emotionButton("😡", "I'm feeling stressed 😡"),
            ],
          ),
        ],
      ),
    );
  }

  /// Chat UI Widget
  Widget _chatWidget() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: _boxDecoration(),
        child: Column(
          children: [
            _chatMessagesList(), // Chat messages list
            _messageInputField(), // Input field with send button
          ],
        ),
      ),
    );
  }

  /// Chat Messages List
  Widget _chatMessagesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _chatBubble(message["sender"] == "user", message["message"]!);
        },
      ),
    );
  }

  /// Input Field with Send Button
  Widget _messageInputField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }

  /// Creates an emotion button
  Widget _emotionButton(String emoji, String message) {
    return GestureDetector(
      onTap: () => _sendMessage(message),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 2), blurRadius: 4)
          ],
        ),
        child: Text(emoji, style: TextStyle(fontSize: 30)),
      ),
    );
  }

  /// Creates a chat bubble
  Widget _chatBubble(bool isUser, String message) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  /// Right Sidebar for Chat History
  Widget _chatHistorySidebar() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text("Chat History", style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(
                    message["message"]!,
                    style: TextStyle(
                      color: message["sender"] == "user"
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                  leading: Icon(
                    message["sender"] == "user"
                        ? Icons.person
                        : Icons.chat_bubble,
                    color:
                        message["sender"] == "user" ? Colors.blue : Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Box Decoration for UI Containers
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 6)
      ],
    );
  }
}
