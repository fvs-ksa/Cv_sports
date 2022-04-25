import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../baseUrlApi/baseUrlApi.dart';

class ServiceAddPlayerProfile {
  //================ Post  sent  sign Up  Email ==================

  Future<Response> postAddPlayerProfile({

   @required  String setHeight,
    @required   String setWeight,
    @required    String setNational,
    @required    String setWeightUnit,
    @required   String setGamePractitioner,
    @required    String setGameSelect,
       String setCvText,
    @required     String setDateTime1SecondScreen,
    @required     String setDateTime2SecondScreen,
    @required    String setNameClub,
     String setNameGameWhere,
    @required    String setRoleId,

  }) async {
    try {
    Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.AddPlayerProfile);
    print("setNameClub = "+ setNameClub);
    FormData formData = new FormData.fromMap(
        {
          "club_name": setNameClub,
          "nationality_id" :setNational,
          "player_role": setNameGameWhere,
          "player_style" :setGamePractitioner,
          "height": setHeight,
          "weight" :setWeight,
          "weight_unit": setWeightUnit,
          "contract_start_date" :setDateTime1SecondScreen,
          "contract_end_date": setDateTime2SecondScreen,
          "role_id" :setRoleId,
          "sport_id": setGameSelect,
          "cv":setCvText,

       });



    formData.fields.removeWhere((element) => element.value.length == 0);


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postAddPlayerProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postAddPlayerProfile  error " + e.response.data.toString());
      return e.response;
    }
  }
  Future<Response> postUpdatePlayerProfile({

    @required  String setHeight,
    @required   String setWeight,
    @required    String setNational,
    @required    String setWeightUnit,
    @required   String setGamePractitioner,
    @required    String setGameSelect,
    String setCvText,
    @required     String setDateTime1SecondScreen,
    @required     String setDateTime2SecondScreen,
    @required    String setNameClub,
    String setNameGameWhere,
    @required    String setRoleId,

  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UpdatePlayerProfile);
      print("setNameClub = "+ setNameClub);
      FormData formData = new FormData.fromMap(
          {
            "club_name": setNameClub,
            "nationality_id" :setNational,
            "player_role": setNameGameWhere,
            "player_style" :setGamePractitioner,
            "height": setHeight,
            "weight" :setWeight,
            "weight_unit": setWeightUnit,
            "contract_start_date" :setDateTime1SecondScreen,
            "contract_end_date": setDateTime2SecondScreen,
            "role_id" :setRoleId,
            "sport_id": setGameSelect,
            "cv":setCvText,

          });



      formData.fields.removeWhere((element) => element.value.length == 0);


      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postAddPlayerProfile " + response.data.toString());
      return response;
    } on DioError catch (e) {
      print("postAddPlayerProfile  error " + e.response.data.toString());
      return e.response;
    }
  }
}
