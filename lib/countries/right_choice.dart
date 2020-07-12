import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightChoice extends StatelessWidget {
  final String answer;

  const RightChoice(this.answer) : super();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width - 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.green.withOpacity(0.6)),
            right: BorderSide(width: 2.0, color: Colors.green.withOpacity(0.6)),
            left: BorderSide(width: 2.0, color: Colors.green.withOpacity(0.6)),
            bottom:
                BorderSide(width: 2.0, color: Colors.green.withOpacity(0.6)),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$answer',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.check,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WrongChoice extends StatelessWidget {
  final String answer;
  final bool userAnswered;
  const WrongChoice(this.answer, this.userAnswered) : super();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width - 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border(
            top: BorderSide(
                width: 2.0,
                color: userAnswered
                    ? Colors.amber.withOpacity(0.6)
                    : Colors.red.withOpacity(0.6)),
            right: BorderSide(
                width: 2.0,
                color: userAnswered
                    ? Colors.amber.withOpacity(0.6)
                    : Colors.red.withOpacity(0.6)),
            left: BorderSide(
                width: 2.0,
                color: userAnswered
                    ? Colors.amber.withOpacity(0.6)
                    : Colors.red.withOpacity(0.6)),
            bottom: BorderSide(
                width: 2.0,
                color: userAnswered
                    ? Colors.amber.withOpacity(0.6)
                    : Colors.red.withOpacity(0.6)),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$answer',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.close,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
