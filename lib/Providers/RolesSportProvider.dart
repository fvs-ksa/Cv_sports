import 'package:cv_sports/Model/RolesSportِApiِِ.dart';
import 'package:cv_sports/Services/AllServices/serviceRolesSportGet.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RolesSportProvider with ChangeNotifier {
  List<RolesSport> listRolesSport = [];

  bool loading = false;
  int sportId;
  String nameCategorySport;

  setSportIdAndUpdateRolesSportData(
      {@required int setSportId, @required String setNameCategorySport}) async {
    sportId = setSportId;

    nameCategorySport = setNameCategorySport;
    listRolesSport = [];
    loading = true;
    await fetchRolesSport();
    loading = false;

    notifyListeners();
  }

  Future<void> fetchRolesSport() async {
    print("sportId = " + sportId.toString());
    Response response =
        await ServiceRolesSportGet().getRolesSports(sportId: sportId);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listRolesSport.add(RolesSport.fromJson(element));
      });

      print("listRolesSport  = " + listRolesSport.length.toString());
    } else {
      listRolesSport = [];
    }
    notifyListeners();
  }

  getRolesSportData() async {
    sportId = null;
    nameCategorySport = null;
    listRolesSport = [];
    loading = true;
    await fetchRolesSport();
    loading = false;

    notifyListeners();
  }
}
