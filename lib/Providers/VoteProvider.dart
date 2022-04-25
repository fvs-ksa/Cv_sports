import 'package:cv_sports/Model/VoteResult.dart';
import 'package:cv_sports/Model/voteApi.dart';
import 'package:cv_sports/Services/AllServices/serviceQuestionVoteGet.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class VoteProvider with ChangeNotifier{


  VoteQuestion listVoteQuestion ;
  VoteResult listVoteResult ;

  int page;
  bool loading = false;


  setLoading({@required bool changeLoading}){
    loading = changeLoading;
    notifyListeners();
  }

  Future<void> fetchVote()async{
    Response response = await ServiceQuestionVoteGet().getServiceQuestionVote();

    if (response.statusCode == 200) {

      listVoteQuestion = VoteQuestion.fromJson( response.data);
      print("listVote  = "+ listVoteQuestion.toString());
    } else {
      listVoteQuestion = null;
    }
    notifyListeners();
  }


  Future<void> fetchVoteResult()async{
    Response response = await ServiceQuestionVoteGet().VoteResultGet(idVote: listVoteQuestion.id);

    if (response.statusCode == 200) {

      listVoteResult = VoteResult.fromJson( response.data);
      print("listVoteResult  = "+ listVoteResult.toString());
    } else {
      listVoteResult = null;
    }
    notifyListeners();
  }


  getVoteData() async {
    loading = true;
    listVoteQuestion = null;
    listVoteResult = null;
    await fetchVote();
    if(BaseUrlApi.tokenUser != null){
      await fetchVoteResult();
    }

    loading = false;

    notifyListeners();
  }
}