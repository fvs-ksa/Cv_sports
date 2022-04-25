import 'dart:convert';

import 'package:cv_sports/Model/Comments.dart';
import 'package:cv_sports/Model/NationalityApi.dart';
import 'package:cv_sports/Services/AllServices/ServicesComments/serviceShowComments.dart';

import 'package:cv_sports/Services/AllServices/serviceNationalityGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProviderShowComments with ChangeNotifier{


  List<Comments> listComments = [];
  int page = 0;

  bool loadingComment = false;
  bool loading = false;

  changeLoading({bool newLoading}) {
    loadingComment = newLoading;
    notifyListeners();
  }

  getNewComments({@required var dataResponse }) {
    // listComments.insert(0, Comments.fromJson(dataResponse));
    // listComments.insert(0, Comments.fromJson(dataResponse));

    // listComments.add(Comments.fromJson(element));
    listComments.insert(0, Comments.fromJson(jsonDecode(dataResponse.data)[0]));

    // listComments.add(Comments.fromJson(dataResponse[0]));
    print("listComments socite = " + listComments.length.toString());
    // notifyListeners();
  }

  Future<void> fetchCommentsApi({@required int idPost}) async {
    // clear old data
    page++;
    Response response = await ServiceShowCommentsAndAllPosts()
        .showComments(idPost: idPost, page: page);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listComments.add(Comments.fromJson(element));
      });
    } else {
      listComments = [];
    }
    notifyListeners();
  }


  getCommentsData({@required int idPost}) async {
    page = 0;

    listComments = [];
    loading = true;
    await fetchCommentsApi(idPost: idPost);
    loading = false;

    notifyListeners();
  }
}