import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class ServiceChat {
  //================  show My Rooms  ==================

  Future<Response> showMyRooms() async {

    try {

      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.ShowAllRoom,  );
      print(uri);


      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("showMyRooms " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showMyRooms  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================  show Other Room  ==================

  Future<Response> showOtherRoom({@required int idUser}) async {

    try {

      Uri uri = Uri.https(BaseUrlApi.baseUrl, "/api/user/chat/rooms/$idUser" );
      print(uri);

      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("showOtherRoom " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showOtherRoom  error " + e.response.data.toString());
      return e.response;
    }
  }
  //================  start Room  ==================

  Future<Response> startRoom({@required int idUser  }) async {

    try {
      Map<String, String> paramars = {
        "receiver_id": idUser.toString(),
      };
      Uri uri = Uri.https(BaseUrlApi.baseUrl, "api/user/chat/rooms/start" ,paramars );
print(uri);


      Response response = await Dio().postUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("startRoom " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("startRoom  error " + e.response.data.toString());
      return e.response;
    }
  }
  //================  show Messages  ==================


  Future<Response> showMessages(
      {@required int idRoom, @required int page}) async {
    try {
      Map<String, String> paramars = {
        "page": page.toString(),
      };
      Uri uri = Uri.https(BaseUrlApi.baseUrl,
          "/api/user/chat/rooms/$idRoom/messages", paramars);

      print(uri);
      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("showComments " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showComments  error " + e.response.data.toString());
      return e.response;
    }
  }
  //================  add New Message  ==================

  Future<Response> addNewMessage({@required int idRoom ,@required String massagesBody }) async {

    try {

      Uri uri = Uri.https(BaseUrlApi.baseUrl, "/api/user/chat/rooms/$idRoom/messages" ,);
      FormData formData = new FormData.fromMap({
        "message": massagesBody,
      });


      Response response = await Dio().postUri(uri,data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("addNewMessage " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("addNewMessage  error " + e.response.data.toString());
      return e.response;
    }
  }


  Future<Response> seenNewMessage({@required int idRoom }) async {

    try {

      Uri uri = Uri.https(BaseUrlApi.baseUrl, "/api/user/chat/rooms/$idRoom/mark-as-seen" ,);



      Response response = await Dio().postUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("seenNewMessage " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("seenNewMessage  error " + e.response.data.toString());
      return e.response;
    }
  }


}
