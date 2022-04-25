import 'package:cv_sports/Model/NewsApi.dart';
import 'package:cv_sports/Services/AllServices/serviceNews.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class NewsProvider with ChangeNotifier{


  List<NewsApi> listNews = [];

  bool loading = false;
  int page = 0;

  Future<void> fetchNews() async {
    page++;
    Response response = await ServiceNews().getNews(page: page);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listNews.add(NewsApi.fromJson(element));
      });

      print("getNews  = "+ listNews.length.toString());
    } else {
      listNews = [];
    }
    notifyListeners();
  }


  getNewsData() async {
    page = 0;

    listNews = [];
    loading = true;
    await fetchNews();
    loading = false;

    notifyListeners();
  }
}