import 'dart:math';

import 'package:cv_sports/Model/VoteResult.dart';
import 'package:cv_sports/Model/voteApi.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ViewVote extends StatelessWidget {
  VoteResult dataVoteResult;
  VoteQuestion dataVote;
  int index;


  ViewVote({this.index,this.dataVote , this.dataVoteResult});

  @override
  Widget build(BuildContext context) {
    //print();
    return Container(
      margin: EdgeInsets.fromLTRB(3, 5, 10, 5),
      width: double.infinity,
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: 38.0,
        animationDuration: 500,

        percent: (dataVoteResult.answer[index].countResultPercentage/100).toDouble(),
        center: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(dataVote.answers[index].icon),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  dataVote.answers[index].answer,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //     myOwnChoice(userChoice == index)
              ],
            ),
            Text(
              dataVoteResult.answer[index].countResultPercentage.toString() +
                  "%",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        //  backgroundColor: Colors.grey,

        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: dataVoteResult.answer.map((e) => e.countResult).reduce(max)==dataVoteResult.answer[index].countResult
            .toDouble()
            ? Colors.green
            : Colors.yellow,
      ),
    );
  }
  Widget myOwnChoice(choice) {
    if (choice) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.white,
        size: 17,
      );
    } else {
      return Container();
    }
  }
}
