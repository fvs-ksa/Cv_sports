import 'package:cv_sports/Model/voteApi.dart';
import 'package:cv_sports/Providers/VoteProvider.dart';
import 'package:cv_sports/Services/AllServices/serviceQuestionVoteGet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectVote extends StatelessWidget {
  VoteQuestion dataVote;
  int index;
  SelectVote({this.dataVote, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10,right: 10 ,left: 10 ,top: 10),
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(right: 10,left: 10),
        width: MediaQuery.of(context).size.width,
        padding:  EdgeInsets.only(right: 10,left: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                  dataVote.answers[index].icon),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              dataVote.answers[index].answer,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
