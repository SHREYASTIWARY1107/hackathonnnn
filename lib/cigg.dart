import 'package:flutter/material.dart';

class QuitSmokingTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Tips to Quit Smoking'),
        backgroundColor: Color.fromARGB(255, 112, 24, 206),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tips to help you quit smoking:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TipCard(
                title: '1. Identify your triggers and avoid them',
                imageAsset: 'assets/trigger.jpg',
              ),
              TipCard(
                title:
                    '2. Try nicotine replacement therapy (gum, patches, lozenges)',
                imageAsset: 'assets/logo.jpg',
              ),
              TipCard(
                title: '3. Get support from friends and family',
                imageAsset: 'assets/images/support.png',
              ),
              TipCard(
                title: '4. Exercise regularly',
                imageAsset: 'assets/images/exercise.png',
              ),
              TipCard(
                title: '5. Find alternative activities',
                imageAsset: 'assets/images/activity.png',
              ),
              TipCard(
                title: '6. Stay motivated',
                imageAsset: 'assets/images/motivation.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String title;
  final String imageAsset;

  const TipCard({
    required this.title,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageAsset,
              width: 80,
              height: 80,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
