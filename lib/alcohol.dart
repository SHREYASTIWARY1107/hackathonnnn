import 'package:flutter/material.dart';

class AlcoholPage extends StatefulWidget {
  @override
  _AlcoholPageState createState() => _AlcoholPageState();
}

class _AlcoholPageState extends State<AlcoholPage> {
  int _mlConsumed = 0;
  int _goalMl = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Your Alcohol'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to the Alcohol Page!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                'Track your alcohol consumption and set goals to reduce or quit drinking.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () async {
                  final ml = await _selectMl(context);
                  if (ml == 0) {
                    _showCongratulations();
                  } else if (ml <= 50) {
                    _showWarning();
                  } else if (ml <= 100) {
                    _showEncouragement();
                  } else {
                    _showEncouragement();
                  }
                  setState(() {
                    _mlConsumed = ml;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Track Consumption',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  final goal = await _selectGoal(context);
                  if (goal != null) {
                    setState(() {
                      _goalMl = goal;
                    });
                    _showAllTheBest();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Set Goals',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Get Support'),
                        content: Text('Call 1-800-ALCOHOL for support.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Get Support',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'ML Consumed: $_mlConsumed',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20.0),
              Text(
                'Goal: $_goalMl ML',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _selectMl(BuildContext context) async {
    final result = await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select ML Consumed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('0 ML'),
                onTap: () {
                  Navigator.pop(context, 0);
                },
              ),
              ListTile(
                title: Text('50 ML'),
                onTap: () {
                  Navigator.pop(context, 50);
                },
              ),
              ListTile(
                title: Text('100 ML'),
                onTap: () {
                  Navigator.pop(context, 100);
                },
              ),
              ListTile(
                title: Text('More than 100 ML'),
                onTap: () {
                  Navigator.pop(context, 150);
                },
              ),
            ],
          ),
        );
      },
    );
    return result ?? 0;
  }

  void _showCongratulations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You are doing great!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: Text('Please drink responsibly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEncouragement() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Keep Going!'),
          content: Text('You are on the right track.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<int?> _selectGoal(BuildContext context) async {
    return await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Your Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('100 ML'),
                onTap: () {
                  Navigator.pop(context, 100);
                },
              ),
              ListTile(
                title: Text('200 ML'),
                onTap: () {
                  Navigator.pop(context, 200);
                },
              ),
              ListTile(
                title: Text('300 ML'),
                onTap: () {
                  Navigator.pop(context, 300);
                },
              ),
              ListTile(
                title: Text('More than 300 ML'),
                onTap: () {
                  Navigator.pop(context, 400);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAllTheBest() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Good Luck!'),
          content: Text('Wishing you all the best to achieve your goal!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AlcoholPage(),
  ));
}
