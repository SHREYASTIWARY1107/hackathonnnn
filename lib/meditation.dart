import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension DateTimeExtension on DateTime {
  DateTime get dateOnly => DateTime(this.year, this.month, this.day);
}

class MeditationPage extends StatefulWidget {
  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  int _selectedDuration = 5; // Initial duration is 5 minutes
  int _streak = 0;
  DateTime? _lastMeditationDate;

  @override
  void initState() {
    super.initState();
    _loadStreak();
  }

  Future<void> _loadStreak() async {
    final today = DateTime.now().dateOnly;
    final yesterday = today.subtract(Duration(days: 1));

    final querySnapshot = await FirebaseFirestore.instance
        .collection('meditations')
        .where('date', isEqualTo: yesterday)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        _streak = 1;
        _lastMeditationDate = yesterday;
      });
    } else {
      setState(() {
        _streak = 0;
        _lastMeditationDate = null;
      });
    }
  }

  Future<void> _playAudio() async {
    final String audioFilePath =
        'assets/meditation_${_selectedDuration}min.mp3';

    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play(DeviceFileSource(audioFilePath));
      _audioPlayer.onDurationChanged.listen((Duration d) {
        setState(() {
          _duration = d;
        });
      });
      _audioPlayer.onPositionChanged.listen((Duration p) {
        setState(() {
          _position = p;
        });
      });
      _audioPlayer.onPlayerComplete.listen((event) {
        _logMeditation();
      });
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  Future<void> _logMeditation() async {
    final now = DateTime.now();
    final date = now.dateOnly;

    if (_lastMeditationDate == null || _lastMeditationDate != date) {
      await FirebaseFirestore.instance.collection('meditations').add({
        'date': date,
        'time': now,
      });

      setState(() {
        _streak = _lastMeditationDate == null
            ? 1
            : _lastMeditationDate!.difference(date).inDays == 1
                ? _streak + 1
                : 1;
        _lastMeditationDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Meditation Duration:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDuration = 5;
                    });
                  },
                  child: Text('5 min'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDuration = 10;
                    });
                  },
                  child: Text('10 min'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDuration = 15;
                    });
                  },
                  child: Text('15 min'),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playAudio,
              child: Text(_isPlaying ? 'Stop' : 'Play'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Streak: $_streak days',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Slider(
              value: _position.inSeconds.toDouble(),
              max: _duration.inSeconds.toDouble(),
              onChanged: (double value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            Text(
              '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
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
