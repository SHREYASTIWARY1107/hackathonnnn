import 'package:flutter/material.dart';
import 'package:aitherapist/cigg.dart';

class CigaretteCalculatorPage extends StatefulWidget {
  @override
  _CigaretteCalculatorPageState createState() =>
      _CigaretteCalculatorPageState();
}

class _CigaretteCalculatorPageState extends State<CigaretteCalculatorPage> {
  final TextEditingController _cigarettesPerDayController =
      TextEditingController();
  final TextEditingController _packPriceController = TextEditingController();
  final TextEditingController _smokingYearsController = TextEditingController();

  double totalCigarettesSmoked = 0;
  double totalMoneySpent = 0;
  double timeLostFromLife = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Cigarette Calculator'),
        backgroundColor: Color.fromARGB(255, 112, 24, 206),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the following details:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cigarettesPerDayController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Cigarettes smoked per day',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 112, 24, 206)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 112, 24, 206)),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _packPriceController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Price of a pack of 20 cigarettes',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 112, 24, 206)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 112, 24, 206)),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _smokingYearsController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Years of smoking',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 112, 24, 206)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 112, 24, 206)),
                ),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _calculateResults,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 112, 24, 206),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Results:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Cigarettes Smoked: $totalCigarettesSmoked',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Total Money Spent: \Rs${totalMoneySpent.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Time Lost from Life: ${timeLostFromLife.toStringAsFixed(2)} years',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuitSmokingTipsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 112, 24, 206),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Get Tips to Quit Smoking',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateResults() {
    double cigarettesPerDay =
        double.tryParse(_cigarettesPerDayController.text) ?? 0;
    double packPrice = double.tryParse(_packPriceController.text) ?? 0;
    double smokingYears = double.tryParse(_smokingYearsController.text) ?? 0;

    totalCigarettesSmoked = cigarettesPerDay * 365 * smokingYears;
    totalMoneySpent = (totalCigarettesSmoked / 20) * packPrice;
    timeLostFromLife = smokingYears *
        0.25; // Assuming an average loss of 0.25 years per year of smoking

    setState(() {});
  }
}
