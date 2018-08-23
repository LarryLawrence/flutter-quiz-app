import 'package:flutter/material.dart';
import '../ui/answer_button.dart';
import '../ui/correct_wrong_overlay.dart';
import '../ui/question_text.dart';
import '../utils/question.dart';
import '../utils/quiz.dart';
import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuizPageState();
  }
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  Quiz quiz = new Quiz(
    [
      new Question('The world will be a better place', true),
      new Question('Pizza is healthy', false),
      new Question('Flutter is awesome', true)
    ],
  );

  //initState acts as a constructor here
  @override
  void initState() {
    print('-------------------> QuizPageState: [initState]');
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = currentQuestion.answer == answer;
    quiz.answer(isCorrect);
    setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('-------------------> QuizPageState: [build]');
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          //this is our main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        overlayShouldBeVisible
            ? new CorrectWrongOverlay(isCorrect, () {
                //update the question
                currentQuestion = quiz.nextQuestion;
                if (currentQuestion == null) {
                  //jump to score page
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              new ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                //set state
                setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : new Container(),
      ],
    );
  }
}
