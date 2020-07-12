import 'package:flutter/material.dart';
import 'package:quiz_app/countries/quiz_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  num highestScore = 0;
  @override
  void initState() {
    super.initState();
    _getHighScore();
  }

  Future<int> _getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final scoreAmount = prefs.getInt('score');
    num finalScore = 0;
    if (scoreAmount == null) {
      finalScore = 0;
    } else {
      finalScore = scoreAmount;
    }
    setState(() {
      highestScore = finalScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Column(
              children: <Widget>[
                Text(
                  'GAME',
                  style: TextStyle(
                    fontSize: 75.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'QUIZ',
                  style: TextStyle(
                    fontSize: 75.0,
                    color: Color.fromRGBO(150, 30, 40, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: 100.0,
              child: Text(
                'Highest Score: ${this.highestScore}',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(),
                ),
              ),
              child: Container(
                height: 50.0,
                width: 250.0,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Start playing',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
