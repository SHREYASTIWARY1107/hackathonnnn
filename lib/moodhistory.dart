import 'package:flutter/material.dart';

class MoodHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Mood History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.blue.shade700],
          ),
        ),
        child: MoodHistoryContent(),
      ),
    );
  }
}

class MoodHistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40.0),
          _buildStreakCard(
            context,
            'Monthly Streak',
            'This month streak:',
            happyCount: 20, // Example data, replace with actual counts
            sadCount: 10, // Example data, replace with actual counts
          ),
          SizedBox(height: 20.0),
          _buildStreakCard(
            context,
            'Weekly Streak',
            'This week streak:',
            happyCount: 15, // Example data, replace with actual counts
            sadCount: 5, // Example data, replace with actual counts
          ),
          SizedBox(height: 20.0),
          _buildStreakCard(
            context,
            'Last Month Streak',
            'Last month streak:',
            happyCount: 25, // Example data, replace with actual counts
            sadCount: 8, // Example data, replace with actual counts
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(
    BuildContext context,
    String title,
    String subtitle, {
    int happyCount = 0,
    int sadCount = 0,
  }) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMoodIndicator('😊', happyCount, Colors.green),
                _buildMoodIndicator('😢', sadCount, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodIndicator(String mood, int count, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30.0,
          child: Text(
            mood,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MoodHistoryPage(),
    debugShowCheckedModeBanner: false,
  ));
}
