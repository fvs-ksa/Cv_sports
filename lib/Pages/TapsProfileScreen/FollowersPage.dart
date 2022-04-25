import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/FollowIng.dart';
import 'package:cv_sports/Pages/Category/PlayerInfomation.dart';
import 'package:cv_sports/Providers/AllFollowProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceFollowing/AllServicesFollow.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class FollowersPage extends StatefulWidget {
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  void initState() {
    Provider.of<AllFollowProvider>(context, listen: false)
        .getListMyFollowersData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Following dataFollowers =
        Provider.of<AllFollowProvider>(context).listMyFollowers;

    return Provider.of<AllFollowProvider>(context).loadingMyFollowers
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
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            body: dataFollowers.records.length == 0
                ? Center(
                    child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sorry, no follow-up has occurred for you.".tr(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ))
                : LazyLoadScrollView(
                    onEndOfPage: () {
                      Provider.of<AllFollowProvider>(context, listen: false)
                          .fetchListMyFollowers();
                    },
                    child: ListView.builder(
                        itemCount: dataFollowers.records.length,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlayerInformation(
                                  userId: dataFollowers.records[index].userId,
                                );
                              }));
                            },
                            trailing: RaisedButton(
                              onPressed: () async {
                                if (BaseUrlApi.idUser ==
                                    dataFollowers.records[index].userId) {
                                  BotToast.showText(
                                    text: "You cannot follow yourself.".tr(),
                                    contentColor: Colors.blue,
                                  );
                                } else {
                                  setState(() {
                                    dataFollowers.records[index].isFollowed =
                                        !dataFollowers
                                            .records[index].isFollowed;
                                  });

                                  await ServiceAllFollow().addAndRemoveFollow(
                                      idFollowAdd:
                                          dataFollowers.records[index].userId);
                                }
                              },
                              elevation: 3,
                              child: dataFollowers.records[index].isFollowed
                                  ? Text(
                                      "follow".tr(),
                                      style: TextStyle(color: Colors.white ,  fontSize: 20),
                                    )
                                  : Text("Follow up".tr(),
                                      style: TextStyle(color: Colors.white, fontSize: 20)),
                              color: dataFollowers.records[index].isFollowed
                                  ? Colors.orange.shade400
                                  : Colors.green.shade400,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    dataFollowers.records[index].avatar)),
                            subtitle: Text(
                              dataFollowers.records[index].role.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            title: Text(
                              dataFollowers.records[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                  ),
          );
  }
}
