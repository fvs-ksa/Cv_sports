import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/FollowIng.dart';
import 'package:cv_sports/Providers/AllFollowProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceFollowing/AllServicesFollow.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'PlayerInfomation.dart';

class OtherFollowing extends StatefulWidget {
  int idUser;


  OtherFollowing({@required this.idUser});
  @override
  _OtherFollowingState createState() => _OtherFollowingState();
}

class _OtherFollowingState extends State<OtherFollowing> {
  @override
  void initState() {
    Provider.of<AllFollowProvider>(context, listen: false)
        .getListOtherFollowingData(idUser: widget.idUser);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Following dataOtherFollowing =
        Provider.of<AllFollowProvider>(context).listOtherFollowing;

    return Provider.of<AllFollowProvider>(context).loadingOtherFollowing
        ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ))
        : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "follow".tr(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
      ),
      body: dataOtherFollowing.records .length == 0
          ? Center(
                    child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No one is watching, until this moment.".tr(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ))
                : LazyLoadScrollView(
                    onEndOfPage: () {
                      Provider.of<AllFollowProvider>(context, listen: false)
                          .fetchListOtherFollowing(idUser: widget.idUser);
                    },
                    child: ListView.builder(
                        itemCount: dataOtherFollowing.records.length,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlayerInformation(
                                  userId:
                                      dataOtherFollowing.records[index].userId,
                                );
                              }));
                            },
                            trailing: RaisedButton(
                              onPressed: () async {
                                if (BaseUrlApi.idUser ==
                                    dataOtherFollowing.records[index].userId) {
                                  BotToast.showText(
                                    text: "You cannot follow yourself.".tr(),
                                    contentColor: Colors.blue,
                                  );
                                } else {
                                  setState(() {
                                    dataOtherFollowing
                                            .records[index].isFollowed =
                                        !dataOtherFollowing
                                            .records[index].isFollowed;
                                  });

                                  await ServiceAllFollow().addAndRemoveFollow(
                                      idFollowAdd: dataOtherFollowing
                                          .records[index].userId);
                                }
                              },
                              elevation: 3,
                              child: dataOtherFollowing
                                      .records[index].isFollowed
                                  ? Text(
                                      "follow".tr(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text("Follow up".tr(),
                                      style: TextStyle(color: Colors.white)),
                              color:
                                  dataOtherFollowing.records[index].isFollowed
                                      ? Colors.orange.shade400
                                      : Colors.green.shade400,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    dataOtherFollowing.records[index].avatar)),
                            subtitle: Text(
                              dataOtherFollowing.records[index].role.toString(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            title: Text(
                              dataOtherFollowing.records[index].name,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }),
                  ),
          );
  }
}
