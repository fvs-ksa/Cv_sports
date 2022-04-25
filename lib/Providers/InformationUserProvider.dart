
import 'package:cv_sports/AuthFuntions/GoogleSignInProvider.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/auth/Login_Screen.dart';
import 'package:cv_sports/Services/AllServices/serviceInformationUserGet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InformationMyProfileProvider with ChangeNotifier{


  Users listInformationUser ;

  bool loading = false;


  Future<void> fetchInformationMyProfile()async{
    Response response = await ServiceInformationUserGet().getInformationProfile();



    if (response.statusCode == 200) {



      listInformationUser= Users.fromJson( response.data["user"]);



     print("ServiceInformationUserGet  = "+ listInformationUser.toJson().toString());

      print("ServiceInformationUserGet  = "+ listInformationUser.toString());
    } else {
      listInformationUser = null;
      SharedPreferences   saveTokenUser = await SharedPreferences.getInstance();
      saveTokenUser.clear();
      GoogleSignInProvider().signOutWithGoogle();

    }
    notifyListeners();
  }


 Future<void> getInformationMyProfileData() async {
    listInformationUser = null;
    loading = true;
    await fetchInformationMyProfile();
    loading = false;




    notifyListeners();
  }
}