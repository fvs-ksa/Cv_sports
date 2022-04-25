import 'dart:convert';

import 'package:cv_sports/Model/CountryApi.dart';
import 'package:cv_sports/Model/GetMassages.dart';
import 'package:cv_sports/Services/AllServices/ServicesChat/ServicesChat.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CommentsChatProvider with ChangeNotifier {
  GetMassages allMassages;

  bool loading = false;
  bool loadingMassage = false;
  int page = 0;

  getNewMassages({@required var dataResponse}) {
    //  allMassages.messages = GetMassages.fromJson(dataResponse.data[0]);\
    // print(Message.fromJson(jsonDecode(dataResponse.data)[0]));

    allMassages.messages
        .insert(0, Message.fromJson(jsonDecode(dataResponse.data)[0]));
    // print(allMassages);
    //  allMassages.messages.insert(0, Message.fromJson(dataResponse));
    // listComments.add(Comments.fromJson(dataResponse[0]));
    // print("allMassages socite = " + allMassages.messages.length.toString());
    notifyListeners();
  }

  changeLoading({bool newLoading}) {
    loadingMassage = newLoading;
    notifyListeners();
  }

  Future<void> fetchMassageApi({@required int allRoomsId}) async {
    // clear old data
    page++;

    Response response =
    await ServiceChat().showMessages(idRoom: allRoomsId, page: page);

    if (response.statusCode == 200) {
      if (page == 1) {
        allMassages = GetMassages.fromJson(response.data);
        notifyListeners();
      } else {
        response.data["messages"].forEach((element) {
          allMassages.messages.add(Message.fromJson(element));
        });
        notifyListeners();
      }
    }
  }

  getMassageData({@required int allRoomsId}) async {
    page = 0;
    allMassages = GetMassages();
    loading = true;
    await fetchMassageApi(allRoomsId: allRoomsId);
    loading = false;

    notifyListeners();
  }
}
