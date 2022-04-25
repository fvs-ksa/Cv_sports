
import 'package:dio/dio.dart';

import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:flutter/material.dart';

class ServiceQuestionVoteGet{
  //================ Post  sent  sign Up  Email ==================


  Future<Response> getServiceQuestionVote() async {
    try {
    Uri uri = Uri.https( BaseUrlApi.baseUrl, BaseUrlApi.getQuestionVote);



      Response response = await Dio().getUri(uri,

          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      print("getServiceQuestionVote " +response.data.toString());
      return response;
    } on DioError catch (e) {


      // NewUser.massageError = e.response.data.toString();
      print("getServiceQuestionVote  error " +e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> VoteResultGet({@required int idVote}) async {

    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, "/api/user/vote/$idVote/show-result");


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("VoteResultGet " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("VoteResultGet  error " + e.response.data.toString());
      return e.response;
    }
  }
  Future<Response> VoteResultAdd({@required int idVote ,@required String answerId}) async {

    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, "api/user/vote/$idVote/add-answer");
    FormData formData = new FormData.fromMap(
        {
          "answer_id":answerId,
        });



      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("VoteResultGet " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("VoteResultGet  error " + e.response.data.toString());
      return e.response;
    }
  }
}


