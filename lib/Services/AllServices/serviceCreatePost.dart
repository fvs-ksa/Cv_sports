import 'dart:io';


import 'package:cv_sports/ProviderAll.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../baseUrlApi/baseUrlApi.dart';

class ServiceCreatePost {
  //================ post Create Post ==================

  Future<Response> postCreatePost({
    @required String postString,

    @required int media,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.CreatePost);
      FormData formData;
      formData = new FormData.fromMap({
        "body": postString,
        "media_id": media,
      });

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postCreatePost " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postCreatePost  error " + e.response.data.toString());
      return e.response;
    }
  }
  Future<Response> postCreatePostClub({
    @required String postString,
    @required String titleBody,
    @required List media,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.CreatePostClub);
      FormData formData;
      formData = new FormData.fromMap({
        "title": titleBody,
        "body": postString,
        "media_id": media.map((e) => e.toString()).toList(),

      });

      Response response = await Dio().postUri(uri,
          data: formData,
          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("postCreatePostClub " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("postCreatePostClub  error " + e.response.data.toString());
      return e.response;
    }
  }
  //================ upload Image Post ==================

  Future<Response> uploadImagePost({
    @required File image,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UploadImagePost);

      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      Response response = await Dio().postUri(uri,
          data: formData,
          onSendProgress: (int sent, int total) {
            print("$sent / Video  / $total");

          },

          options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("UploadImagePost " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("UploadImagePost  error " + e.response.data.toString());
      return e.response;
    }
  }
  //================ upload Video Post ==================

  Future<Response> uploadVideoPost({
    @required File image,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UploadVideoPost);

      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      Response response = await Dio().postUri(uri, data: formData,
          onSendProgress: (int sent, int total) {
        print("$sent / Video  / $total");
      }, options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("uploadVideoPost " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("uploadVideoPost  error " + e.response.data.toString());
      return e.response;
    }
  }
}
