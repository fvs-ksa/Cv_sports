import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class ServiceAllFollow {
  //================  show My Rooms  ==================

  Future<Response> showMyFollowers({@required int page}) async {
    Map<String, String> paramars = {
      "page": page.toString(),
    };
    try {
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.ShowAllFollowers, paramars);
      print(uri);

      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("showMyFollowers " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showMyFollowers  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================  show Other Room  ==================

  Future<Response> showMyFollowing({@required int page}) async {
    try {
      Map<String, String> paramars = {
        "page": page.toString(),
      };
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.ShowAllFollowing, paramars);
      print(uri);

      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("showMyFollowing " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showMyFollowing  error " + e.response.data.toString());
      return e.response;
    }
  }
  //================  start Room  ==================

  Future<Response> addAndRemoveFollow({
    @required int idFollowAdd,
  }) async {
    try {
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, "/api/user/follow/$idFollowAdd/add");

      Response response = await Dio().postUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("addAndRemoveFollow " + response.data.toString());
      print("addAndRemoveFollow " + response.statusCode.toString());

      return response;
    } on DioError catch (e) {
      print("addAndRemoveFollow  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================  show Messages  ==================

  Future<Response> showOtherFollowers(
      {@required int idFollowers, @required int page}) async {
    Map<String, String> paramars = {
      "page": page.toString(),
    };
    try {
      Uri uri = Uri.https(
          BaseUrlApi.baseUrl, "/api/user/$idFollowers/followers", paramars);
print(uri);
      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("showOtherFollowers " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("showOtherFollowers  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================  add New Message  ==================

  Future<Response> showOtherFollowing(
      {@required int idFollowing, @required int page}) async {
    Map<String, String> paramars = {
      "page": page.toString(),
    };
    try {
      Uri uri = Uri.https(
          BaseUrlApi.baseUrl, "/api/user/$idFollowing/followings", paramars);
      print(uri);

      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));
      print("showOtherFollowing " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showOtherFollowing  error " + e.response.data.toString());
      return e.response;
    }
  }




}
