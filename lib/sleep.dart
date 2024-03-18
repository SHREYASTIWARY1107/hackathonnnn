import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentTip = '';

  final List<String> _sleepTips = [
    'Take slow, deep breaths and focus on your breathing.',
    'Visualize a peaceful scene or imagine yourself in a relaxing environment.',
    'Practice progressive muscle relaxation by tensing and releasing each muscle group.',
    'Repeat a calming mantra or affirmation to yourself.',
    'Perform gentle stretches or yoga poses to release tension.',
    'Use aromatherapy with calming essential oils like lavender or chamomile.',
    'Listen to soothing nature sounds or soft, instrumental music.',
  ];

  @override
  void initState() {
    super.initState();
    _updateTip();
  }

  Future<void> _playMusic() async {
    final String audioFilePath = 'assets/sleep_music.mp3';

    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play(DeviceFileSource(audioFilePath));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _updateTip() {
    setState(() {
      _currentTip = _sleepTips[DateTime.now().second % _sleepTips.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Page'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.lightBlue, Colors.green],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Sleep Page',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _playMusic,
              style: ElevatedButton.styleFrom(
                primary: _isPlaying ? Colors.redAccent : Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: Text(
                _isPlaying ? 'Stop Music' : 'Play Music',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 50.0),
            Text(
              'Sleep Meditation Tip:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                _currentTip,
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _updateTip,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: Text(
                'Next Tip',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SleepPage(),
  ));
}
