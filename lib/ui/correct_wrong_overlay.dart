import 'dart:math';
import 'package:flutter/material.dart';

//we are going to have animation here so we extend stateful widget
class CorrectWrongOverlay extends StatefulWidget {
  final bool _isCorrect;
  final VoidCallback _onTap;

  const CorrectWrongOverlay(this._isCorrect, this._onTap);

  @override
  State<StatefulWidget> createState() => new CorrectWrongOverlayState();
}

// get used to writing this out..
class CorrectWrongOverlayState extends State<CorrectWrongOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 600), vsync: this);
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceInOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
          onTap: () => widget._onTap(),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: new Transform.rotate(
                    //_iconAnimation.value goes from 0, 0.1 ...to 1
                    angle: _iconAnimation.value * 2 * PI,
                    child: new Icon(
                      widget._isCorrect ? Icons.done : Icons.clear,
                      size: _iconAnimation.value * 80.0,
                    )),
              ),
              //add some padding between container and text
              new Padding(
                padding: new EdgeInsets.only(bottom: 20.0),
              ),
              new Text(
                widget._isCorrect == true ? "Correct!" : "wrong",
                style: new TextStyle(color: Colors.white, fontSize: 30.0),
              )
            ],
          )),
    );
  }
}
