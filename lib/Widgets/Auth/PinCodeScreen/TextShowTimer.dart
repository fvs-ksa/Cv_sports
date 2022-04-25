import 'package:flutter/material.dart';




class TextShowTimer extends StatelessWidget {
  int timerCount;

  TextShowTimer({ @required this.timerCount});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'انتظر ليتم اسقبال رقم جديد ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.timer),
            )),
        SizedBox(
          width: 5,
        ),
        Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                timerCount.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }
}
