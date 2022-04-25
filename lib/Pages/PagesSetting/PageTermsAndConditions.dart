//PageTermsAndConditions
import 'package:cv_sports/Services/AllServices/SettingsServices/ServiceAboutUs.dart';
import 'package:cv_sports/Services/AllServices/SettingsServices/ServiceTermsAndConditions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PageTermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Terms and Conditions".tr(),
          style: TextStyle(fontSize: 20),
        ),
      ),
      body:  FutureBuilder<Response>(
          future:  ServiceTermsAndConditions().getTermsAndConditions(),
          builder: (context, snapshot) {

            if(snapshot.connectionState ==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(backgroundColor:  Colors.red,),
              );
            }else {
              return SingleChildScrollView(
                child: Center(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text(
                          snapshot.data.data["content"],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
