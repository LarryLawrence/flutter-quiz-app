import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  const QuestionText(this._question, this._questionNumber);

  @override
  State<StatefulWidget> createState() {
    return new QuestionTextState();
  }
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    print('-------------------> QuestionText: [initState]');
    super.initState();
    _fontSizeAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 400), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizeAnimationController, curve: Curves.linear);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    print('-------------------> QuestionText: [dispose]');
    _fontSizeAnimationController.dispose();
    super.dispose();

  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    print('-------------------> QuestionText: [didUpdateWidget]');
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 20.0),
        child: new Center(
          child: new Text(
            'Statement ' +
                widget._questionNumber.toString() +
                ': ' +
                widget._question,
            style: new TextStyle(fontSize: _fontSizeAnimation.value * 15),
          ),
        ),
      ),
    );
  }
}
