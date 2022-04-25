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

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  void initState() {
    Provider.of<AllFollowProvider>(context, listen: false)
        .getListMyFollowingData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Following dataFollowing =
        Provider.of<AllFollowProvider>(context).listMyFollowing;

    return Provider.of<AllFollowProvider>(context).loadingMyFollowing
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
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: dataFollowing.records.length == 0
                ? Center(
                    child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sorry, no follow-up has occurred.".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ))
                : LazyLoadScrollView(
                    onEndOfPage: () {
                      Provider.of<AllFollowProvider>(context, listen: false)
                          .fetchListMyFollowing();
                    },
                    child: ListView.builder(
                        itemCount: dataFollowing.records.length,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlayerInformation(
                                  userId: dataFollowing.records[index].userId,
                                );
                              }));
                            },
                            trailing: RaisedButton(
                              onPressed: () async {
                                if (BaseUrlApi.idUser ==
                                    dataFollowing.records[index].userId) {
                                  BotToast.showText(
                                    text: "You cannot follow yourself.".tr(),
                                    contentColor: Colors.blue,
                                  );
                                } else {
                                  setState(() {
                                    dataFollowing.records[index].isFollowed =
                                        !dataFollowing
                                            .records[index].isFollowed;
                                  });

                                  await ServiceAllFollow().addAndRemoveFollow(
                                      idFollowAdd:
                                          dataFollowing.records[index].userId);
                                }
                              },
                              elevation: 3,
                              child: dataFollowing.records[index].isFollowed
                                  ? Text(
                                      "follow".tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text("Follow up".tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      )),
                              color: dataFollowing.records[index].isFollowed
                                  ? Colors.orange.shade400
                                  : Colors.green.shade400,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    dataFollowing.records[index].avatar)),
                            subtitle: Text(
                              dataFollowing.records[index].role.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            title: Text(
                              dataFollowing.records[index].name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                  ),
          );
  }
}
