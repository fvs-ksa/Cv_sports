import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/VideosApiHomePage.dart';

import 'package:cv_sports/Services/AllServices/serviceCountryGet.dart';
import 'package:cv_sports/Services/AllServices/serviceVideosGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class VideosHomePageProvider with ChangeNotifier{


  List<Videos> listVideos = [];


  bool loading = false;




  Future<void> fetchVideosApi() async {
    // clear old data
    listVideos = [];

    Response response = await ServiceVideosGet().VideosGet();

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listVideos.add(Videos.fromJson(element));
      });


    } else {
      listVideos = [];
    }
    notifyListeners();
  }



  getVideoData() async {

    listVideos = [];
    loading = true;
    await fetchVideosApi( );
    loading = false;

    notifyListeners();
  }
}