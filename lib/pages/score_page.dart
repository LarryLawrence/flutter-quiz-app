import 'package:flutter/material.dart';
import 'package:second_flutter_app/pages/landing_page.dart';

class ScorePage extends StatelessWidget {
  final int _score;
  final int _totalQuestions;

  ScorePage(this._score, this._totalQuestions);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blue,
      child: new InkWell(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Your score is: ",
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            new Text(_score.toString() + "/" + _totalQuestions.toString(),
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold)),
            new IconButton(
              icon: new Icon(Icons.arrow_right),
              color: Colors.white,
              iconSize: 80.0,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LandingPage()),
                    (Route route) => route == null);
              },
            )
          ],
        ),
      ),
    );
  }
}
