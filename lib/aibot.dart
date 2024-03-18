import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIPage extends StatefulWidget {
  final String userId;

  AIPage({required this.userId});

  @override
  _AIPageState createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  TextEditingController _inputController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chatbot Page'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('User ID: ${widget.userId}'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.blue.shade50],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    String message = _inputController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: message,
          sender: Sender.User,
          time: DateTime.now(),
        ),
      );
      _inputController.clear();
    });

    // Make API call with the user's message and user ID
    var requestBody = jsonEncode({
      'input': message,
      'user_id': widget.userId,
    });

    var response = await http.post(
      Uri.parse('https://aitherapistapi.onrender.com/ai_therapist'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: responseBody['response'],
            sender: Sender.Bot,
            time: DateTime.now(),
          ),
        );
      });
    } else {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: 'Error: Failed to fetch response',
            sender: Sender.Bot,
            time: DateTime.now(),
          ),
        );
      });
    }
  }
}

enum Sender { User, Bot }

class ChatMessage extends StatelessWidget {
  final String text;
  final Sender sender;
  final DateTime time;

  const ChatMessage({
    required this.text,
    required this.sender,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: sender == Sender.User
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            '${time.hour}:${time.minute}',
            style: TextStyle(color: Colors.grey),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: sender == Sender.User ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sender == Sender.User ? 16.0 : 0),
                topRight: Radius.circular(sender == Sender.User ? 0 : 16.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: sender == Sender.User ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
