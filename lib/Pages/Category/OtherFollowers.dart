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

class OtherFollowers extends StatefulWidget {

  int idUser;


  OtherFollowers({@required this.idUser});

  @override
  _OtherFollowersState createState() => _OtherFollowersState();
}

class _OtherFollowersState extends State<OtherFollowers> {
  @override
  void initState() {
    Provider.of<AllFollowProvider>(context, listen: false)
        .getListOtherFollowersData(idUser: widget.idUser);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Following dataOtherFollowers =
        Provider.of<AllFollowProvider>(context).listOtherFollowers;

    return Provider.of<AllFollowProvider>(context).loadingOtherFollowers
        ? Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ))
        : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Followers".tr(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
      body: dataOtherFollowers.records.length == 0
          ? Center(
                    child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No one is following up, until this moment.".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ))
                : LazyLoadScrollView(
                    onEndOfPage: () {
                      Provider.of<AllFollowProvider>(context, listen: false)
                          .fetchListOtherFollowers(idUser: widget.idUser);
                    },
                    child: ListView.builder(
                        itemCount: dataOtherFollowers.records.length,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlayerInformation(
                                  userId:
                                      dataOtherFollowers.records[index].userId,
                                );
                              }));
                            },
                            trailing: RaisedButton(
                              onPressed: () async {
                                if (BaseUrlApi.idUser ==
                                    dataOtherFollowers.records[index].userId) {
                                  BotToast.showText(
                                    text: "You cannot follow yourself.".tr(),
                                    contentColor: Colors.blue,
                                  );
                                } else {
                                  setState(() {
                                    dataOtherFollowers
                                            .records[index].isFollowed =
                                        !dataOtherFollowers
                                            .records[index].isFollowed;
                                  });

                                  await ServiceAllFollow().addAndRemoveFollow(
                                      idFollowAdd: dataOtherFollowers
                                          .records[index].userId);
                                }
                              },
                              elevation: 3,
                              child: dataOtherFollowers
                                      .records[index].isFollowed
                                  ? Text(
                                      "follow".tr(),
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    )
                                  : Text("Follow up".tr(),
                                      style: TextStyle(color: Colors.white , fontSize: 20)),
                              color:
                                  dataOtherFollowers.records[index].isFollowed
                                      ? Colors.orange.shade400
                                      : Colors.green.shade400,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    dataOtherFollowers.records[index].avatar)),
                            subtitle: Text(
                              dataOtherFollowers.records[index].role.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            title: Text(
                              dataOtherFollowers.records[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                  ),
          );
  }
}
