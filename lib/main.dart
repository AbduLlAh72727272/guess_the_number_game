import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(GuessingGame());
}

class GuessingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuessingScreen(),
    );
  }
}

class GuessingScreen extends StatefulWidget {
  @override
  _GuessingScreenState createState() => _GuessingScreenState();
}

class _GuessingScreenState extends State<GuessingScreen> {
  late int _randomNumber;
  late int _guess;
  String _message = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  void _generateRandomNumber() {
    final random = Random();
    _randomNumber = random.nextInt(100) + 1; // Generates a random number between 1 and 100
  }

  void _checkGuess() {
    setState(() {
      _guess = int.tryParse(_controller.text)!;
      if (_guess != null) {
        if (_guess == _randomNumber) {
          _message = 'Congratulations! You guessed the number $_randomNumber!';
        } else if (_guess < _randomNumber) {
          _message = 'Too low. Try again!';
        } else {
          _message = 'Too high. Try again!';
        }
      } else {
        _message = 'Please enter a valid number!';
      }
    });
  }

  void _resetGame() {
    setState(() {
      _generateRandomNumber();
      _controller.clear();
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guessing Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your guess',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              child: Text('Check'),
            ),
            SizedBox(height: 20),
            Text(_message),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
