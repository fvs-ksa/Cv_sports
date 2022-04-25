
import 'package:cv_sports/Model/usersApi.dart';

import 'package:cv_sports/Services/AllServices/ServiceInformationUser.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserInformationProvider with ChangeNotifier {

  int page;
  bool loading = false;
  Users listInformationUser = Users() ;
  Future<void> fetchInformationUser({@required int userId}) async {


    Response response =
        await ServiceInformationUser().getInformationUser(userId: userId);

    if (response.statusCode == 200) {

      listInformationUser= Users.fromJson( response.data["user"]);



    } else {
      listInformationUser = Users() ;

    }
    notifyListeners();
  }

  Future<void> getInformationUser({@required int userId}) async {
    listInformationUser= Users() ;
    loading = true;
    await fetchInformationUser(userId: userId);
    loading = false;

    notifyListeners();
  }
}
