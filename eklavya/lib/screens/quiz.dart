import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:eklavya/screens/ScoreScreen.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'What is the capital of France?',
      options: ['Berlin', 'Madrid', 'Paris', 'Lisbon'],
      correctAnswerIndex: 2,
    ),
    QuizQuestion(
      question: 'Who wrote "Hamlet"?',
      options: ['Charles Dickens', 'William Shakespeare', 'Leo Tolstoy', 'Mark Twain'],
      correctAnswerIndex: 1,
    ),
    // Add more questions as needed
  ];

  int _currentStep = 0;
  List<int?> _answers = [];
  late Timer _timer;
  int _remainingTime = 10; // 10 seconds per question
  int _score = 0;
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _answers = List<int?>.filled(questions.length, null);
    _startTimer();
    WidgetsBinding.instance!.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused && !_quizCompleted) {
      _handleAppPause();
    }
  }

  void _handleAppPause() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CheatingScreen()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _startTimer() {
    _remainingTime = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _goToNextStep();
      }
    });
  }

  void _goToNextStep() {
    _timer.cancel();
    if (_currentStep < questions.length - 1) {
      setState(() {
        _currentStep++;
        _startTimer();
      });
    } else {
      _quizCompleted = true;
      _calculateScore();
    }
  }

  void _calculateScore() {
  Map<String, dynamic> answeredQuestions = {};

  for (int i = 0; i < questions.length; i++) {
    String question = questions[i].question;
    int? answerIndex = _answers[i];
    String selectedOption = questions[i].options[answerIndex!];
    answeredQuestions[question] = selectedOption;
    
    if (answerIndex == questions[i].correctAnswerIndex) {
      _score++;
    }
  }

  // Print answered questions to console
  print('Answered Questions:');
  answeredQuestions.forEach((question, answer) {
    print('$question: $answer');
  });

  // Navigate to score screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => ScoreScreen(score: _score, totalQuestions: questions.length)),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _goToNextStep,
          steps: questions.map((question) {
            int stepIndex = questions.indexOf(question);
            return Step(
              title: Text('Question ${stepIndex + 1}'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question.question),
                  SizedBox(height: 10),
                  for (int i = 0; i < question.options.length; i++)
                    RadioListTile<int>(
                      title: Text(question.options[i]),
                      value: i,
                      groupValue: _answers[stepIndex],
                      onChanged: (value) {
                        setState(() {
                          _answers[stepIndex] = value;
                        });
                      },
                    ),
                  SizedBox(height: 10),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: _remainingTime / 10,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                  SizedBox(height: 5),
                  Text('Time remaining: $_remainingTime seconds'),
                ],
              ),
              isActive: _currentStep == stepIndex,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CheatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Ended Prematurely',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'You left the quiz incomplete.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
