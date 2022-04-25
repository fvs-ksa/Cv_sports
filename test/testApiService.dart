import 'package:cv_sports/Services/AllServices/ServiceInformationUser.dart';
import 'package:cv_sports/Services/AllServices/ServiceUsersGet.dart';
import 'package:cv_sports/Services/AllServices/serviceCategorySports.dart';
import 'package:cv_sports/Services/AllServices/serviceInformationUserGet.dart';
import 'package:cv_sports/Services/AllServices/serviceRolesSportGet.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Services/AllServices/serviceCityGet.dart';
import 'package:cv_sports/Services/AllServices/serviceCountryGet.dart';
import 'package:cv_sports/Services/AllServices/serviceInformationUserUpdate.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  BaseUrlApi.tokenUser = "5|4rcY6xRaK2DSMcXmTMX13HHSxx8wJ3qRYFeJWeke";






  //====================================== Service City Get  ==================================
  test('Service  City  Get', () async {
    Response response = await ServiceCityGet().getCity(countryId:  1.toString());

    print("response Service City Get = " + response.data.toString());

    expect(response.statusCode, 200);
  });
  //====================================== Service Country Get ==================================
  test('Service Country Get', () async {
    Response response = await ServiceCountryGet().countryGet();

    print("response Service Country Get = " + response.data.toString());

    expect(response.statusCode, 200);
  });


//====================================== Service Information User ==================================
  test('Service Information User Get', () async {
    Response response = await ServiceInformationUser().getInformationUser(userId: 1);

    print("response Service Information User Get = " + response.data.toString());

    expect(response.statusCode, 200);
  });
//====================================== Service Users Get ==================================
  test('Service Users Get', () async {
    Response response = await ServiceUsersGet().getUsers(roleId: 1,page: 1);

    print("response Users Get = " + response.data.toString());

    expect(response.statusCode, 200);
  });
  //====================================== Service Roles Sport Get ==================================
  test('Service Roles Sport Get', () async {
    Response response = await ServiceRolesSportGet().getRolesSports();

    print("response Service Roles Sport Get = " + response.data.toString());

    expect(response.statusCode, 200);
  });
  //====================================== Service Information User Update ==================================
  test('Service Information User Update', () async {
    Response response = await ServiceInformationUserUpdate().postInformationUserUpdate();

    print("response Service Information User Update = " + response.data.toString());

    expect(response.statusCode, 200);
  });

  //====================================== Service Information User Get ==================================
  test('Service Information User Get', () async {
    Response response = await ServiceInformationUserGet().getInformationProfile();

    print("response  Service Information User Get = " + response.data.toString());

    expect(response.statusCode, 200);
  });
  //====================================== Service Category Sports ==================================
  test('Service Category Sports', () async {
    Response response = await ServiceCategorySports().getCategorySports();

    print("response Service Category Sports Get = " + response.data["sports"].toString());

    expect(response.statusCode, 200);
  });

}
