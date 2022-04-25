import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class ServiceShowCommentsAndAllPosts {
  Future<Response> closeComments({@required int idPost}) async {
    try {
      Uri uri = Uri.https(
        BaseUrlApi.baseUrl,
        "/api/user/post/$idPost/close-comments",
      );

      Response response = await Dio().postUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("closeComments " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("closeComments  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future<Response> deleteComments({@required int idPost}) async {
    try {
      Uri uri = Uri.https(
        BaseUrlApi.baseUrl,
        "/api/user/post/$idPost/delete",
      );

      print(uri);

      Response response = await Dio().deleteUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("deleteComments " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("deleteComments  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================ showComments ==================

  Future<Response> showComments(
      {@required int idPost, @required int page}) async {
    try {
      Map<String, String> paramars = {
        "limit": "10",
        "page": page.toString(),
      };
      Uri uri = Uri.https(
          BaseUrlApi.baseUrl, "/api/user/post/$idPost/comments", paramars);
      print(uri);
      Response response = await Dio().getUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      print("showComments " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("showComments  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================showAllPost ==================
  Future<Response> showAllPost({
    @required int page,
  }) async {
    Map<String, String> paramars = {
      "page": page.toString(),
    };
    Response response;
    try {
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.ShowAllPosts, paramars);
      if (BaseUrlApi.tokenUser != null) {
         response = await Dio().getUri(uri,
            options: Options(headers: BaseUrlApi().getHeaderWithInToken()));
      }else{
         response = await Dio().getUri(uri,
            options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));

      }


      print("showAllPost " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("showAllPost  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================addComments ==================

  Future<Response> addComments(
      {@required int idPost, @required String body}) async {
    try {
      Uri uri = Uri.https(
        BaseUrlApi.baseUrl,
        "/api/user/comment/create/$idPost",
      );
      FormData formData = new FormData.fromMap({
        "body": body,
      });

      Response response = await Dio().postUri(uri,data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("addComments " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("addComments  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================addLike ==================

  Future<Response> addLike({@required int idPost  }) async {

    try {

      Uri uri = Uri.https(BaseUrlApi.baseUrl, "/api/user/post/$idPost/like" ,);



      Response response = await Dio().postUri(uri,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("addLike " + response.data.toString());

      return response;
    } on DioError catch (e) {
      print("addLike  error " + e.response.data.toString());
      return e.response;
    }
  }

  //================ showSinglePost ==================

  Future<Response> showSinglePost({
    @required int idPost,
    @required int page,
  }) async {
    Map<String, String> paramars = {
      "page": page.toString(),
    };
    Response response;
    try {
      Uri uri =
          Uri.https(BaseUrlApi.baseUrl, "/api/user/post/$idPost", paramars);
      if (BaseUrlApi.tokenUser != null) {
         response = await Dio().getUri(uri,
            options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      }else{
         response = await Dio().getUri(uri,
            options: Options(headers: BaseUrlApi().getHeaderWithoutToken()));


      }

      print("showSinglePost " + response.data.toString());

      return response;
    } on DioError catch (e) {

      print("showSinglePost  error " + e.response.data.toString());
      return e.response;
    }
  }

}
