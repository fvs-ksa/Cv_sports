import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Services/AllServices/ServiceUsersGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class UsersProvider with ChangeNotifier{


  List<Users> listUsers = [];
  int page = 0;
  bool loading = false;

  Future<void> fetchUsers({int sportId, int roleId}) async {
    page++;
    print("page " + page.toString());
    Response response = await ServiceUsersGet()
        .getUsers(sportId: sportId, roleId: roleId, page: page);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        listUsers.add(Users.fromJson(element));
      });

      print("listUsers  = " + listUsers.length.toString());
    } else {
      listUsers = [];
    }
    notifyListeners();
  }


  getUsersData({ int sportId, int roleId}) async {
    page = 0;
    listUsers = [];
    loading = true;
    await fetchUsers(roleId: roleId, sportId: sportId);
    loading = false;

    notifyListeners();
  }
}