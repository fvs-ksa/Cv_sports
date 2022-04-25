import 'package:cv_sports/Model/FollowIng.dart';
import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Services/AllServices/ServiceFollowing/AllServicesFollow.dart';
import 'package:cv_sports/Services/AllServices/serviceCategorySports.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllFollowProvider with ChangeNotifier {
  Following listMyFollowing = Following();
  Following listMyFollowers = Following();
  Following listOtherFollowing = Following();
  Following listOtherFollowers = Following();

  bool loadingMyFollowing = false;
  bool loadingMyFollowers = false;
  bool loadingOtherFollowing = false;
  bool loadingOtherFollowers = false;

  int page1 = 0;
  int page2 = 0;
  int page3 = 0;
  int page4 = 0;

  Future<void> fetchListMyFollowing() async {
    page1++;

    Response response = await ServiceAllFollow().showMyFollowing(page: page1);

    if (response.statusCode == 200) {
      if (page1 == 1) {
        listMyFollowing = Following.fromJson(response.data);
      } else {
        response.data["records"].forEach((element) {
          listMyFollowing.records.add(Record.fromJson(element));
        });
      }
      //  listMyFollowing = Following.fromJson(response.data);
      //   listMyFollowing.records.add(response.data["records"]);

      print("listMyFollowing  = " + listMyFollowing.records.length.toString());
    } else {
      listMyFollowing = Following();
    }
    notifyListeners();
  }

  Future<void> fetchListMyFollowers() async {
    page2++;
    Response response = await ServiceAllFollow().showMyFollowers(page: page2);

    if (response.statusCode == 200) {
      if (page2 == 1) {
        listMyFollowers = Following.fromJson(response.data);
      } else {
        response.data["records"].forEach((element) {
          listMyFollowers.records.add(Record.fromJson(element));
        });
      }

      //  listMyFollowers = Following.fromJson(response.data);
      //  listMyFollowers.records.add(response.data["records"]);

      print("listMyFollowers  = " + listMyFollowers.records.length.toString());
    } else {
      listMyFollowers = Following();
    }
    notifyListeners();
  }

  Future<void> fetchListOtherFollowing({@required int idUser}) async {
    page3++;
    Response response = await ServiceAllFollow()
        .showOtherFollowing(idFollowing: idUser, page: page3);

    if (response.statusCode == 200) {
      if (page3 == 1) {
        listOtherFollowing = Following.fromJson(response.data);
      } else {
        response.data["records"].forEach((element) {
          listOtherFollowing.records.add(Record.fromJson(element));
        });
      }

      //     listOtherFollowing = Following.fromJson(response.data);
      //  listOtherFollowing.records.add(response.data["records"]);
      print("listOtherFollowing  = " +
          listOtherFollowing.records.length.toString());
    } else {
      listOtherFollowing = Following();
    }
    notifyListeners();
  }

  Future<void> fetchListOtherFollowers({@required int idUser}) async {
    page4++;
    Response response = await ServiceAllFollow()
        .showOtherFollowers(idFollowers: idUser, page: page4);

    if (response.statusCode == 200) {
      if (page4 == 1) {
        listOtherFollowers = Following.fromJson(response.data);
      } else {
        response.data["records"].forEach((element) {
          listOtherFollowers.records.add(Record.fromJson(element));
        });
      }

      // listOtherFollowers.records.add( Following.fromJson( response.data).records);
      print("listOtherFollowers  = " +
          listOtherFollowers.records.length.toString());
    } else {
      listOtherFollowers = Following();
    }
    notifyListeners();
  }

//========= getListMyFollowingData ===========
  getListMyFollowingData() async {
    listMyFollowing = Following();
    page1 = 0;
    //  print("listMyFollowing = "+listMyFollowing.records.length.toString() );
    loadingMyFollowing = true;
    await fetchListMyFollowing();
    loadingMyFollowing = false;

    notifyListeners();
  }

  //========= getListMyFollowersData ===========

  getListMyFollowersData() async {
    page2 = 0;
    listMyFollowers = Following();
    //   print("listMyFollowers = "+listMyFollowers.records.length.toString() );
    loadingMyFollowers = true;
    await fetchListMyFollowers();
    loadingMyFollowers = false;

    notifyListeners();
  }
  //========= getListOtherFollowingData ===========

  getListOtherFollowingData({@required int idUser}) async {
    page3 = 0;
    listOtherFollowing = Following();
    // print("listOtherFollowing = "+listOtherFollowing.records.length.toString() );

    loadingOtherFollowing = true;
    await fetchListOtherFollowing(idUser: idUser);
    loadingOtherFollowing = false;

    notifyListeners();
  }
  //========= getListOtherFollowersData ===========

  getListOtherFollowersData({@required int idUser}) async {
    page4 = 0;
    listOtherFollowers = Following();
    //print("listOtherFollowers = "+listOtherFollowers.records.length.toString() );

    loadingOtherFollowers = true;
    await fetchListOtherFollowers(idUser: idUser);
    loadingOtherFollowers = false;

    notifyListeners();
  }
}
