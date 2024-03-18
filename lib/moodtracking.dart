import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodTrackingPage extends StatefulWidget {
  @override
  _MoodTrackingPageState createState() => _MoodTrackingPageState();
}

class _MoodTrackingPageState extends State<MoodTrackingPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _selectedMood;
  List<MoodRecord> _moodHistory = [];

  @override
  void initState() {
    super.initState();
    _loadMoodHistory();
  }

  Future<void> _loadMoodHistory() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot snapshot = await _firestore
          .collection('moodRecords')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .get();

      setState(() {
        _moodHistory = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return MoodRecord(
            mood: data['mood'],
            timestamp: (data['timestamp'] as Timestamp).toDate(),
          );
        }).toList();
      });
    }
  }

  Future<void> _saveMood(String mood) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('moodRecords').add({
        'mood': mood,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.uid,
      });
      setState(() {
        _selectedMood = null;
      });
      _loadMoodHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracking'),
        backgroundColor: Colors.blue, // Changed app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMood,
              decoration: InputDecoration(
                labelText: 'How are you feeling?',
                border: OutlineInputBorder(),
              ),
              items: <String>[
                'Happy',
                'Sad',
                'Angry',
                'Excited',
                'Calm',
                'Anxious',
                'Stressed',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMood = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedMood != null
                  ? () => _saveMood(_selectedMood!)
                  : null,
              child: Text('Save Mood'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button color
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _moodHistory.isEmpty
                  ? Center(child: Text('No mood records found.'))
                  : ListView.builder(
                      itemCount: _moodHistory.length,
                      itemBuilder: (context, index) {
                        final mood = _moodHistory[index];
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              mood.mood,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // Text color
                              ),
                            ),
                            subtitle: Text(
                              'Recorded on: ${mood.timestamp.toString()}',
                              style: TextStyle(
                                color: Colors.grey, // Subtitle text color
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodRecord {
  final String mood;
  final DateTime timestamp;

  MoodRecord({required this.mood, required this.timestamp});
}
