import 'package:cv_sports/Model/NotificationApi.dart';
import 'package:cv_sports/Providers/ProviderNofitcition.dart';
import 'package:cv_sports/Services/AllServices/NotificationsSeen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationApi listNotifications;
  @override
  void initState() {
    Provider.of<ProviderNofitcition>(context, listen: false)
        .getNofitcitionData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listNotifications =
        Provider.of<ProviderNofitcition>(context).ListNofitcition;

    return Provider.of<ProviderNofitcition>(context).loading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
        : WillPopScope(
            onWillPop: () {
              Provider.of<ProviderNofitcition>(context, listen: false)
                  .ListNofitcition
                  .unreadCount = 0;
              ServiceNotificationsSeen().postNotificationsSeen();
              Navigator.pop(context);
              return null;
            },
            child: Scaffold(
              backgroundColor: Color(0xffF4F7FF),
              appBar: AppbarBuild(),
              body: Container(
                margin: EdgeInsets.only(top: 10),
                // color: Color(0xffF4F7FF),
                child: LazyLoadScrollView(
                  onEndOfPage: () {
                    Provider.of<ProviderNofitcition>(context, listen: false)
                        .fetchNofitcition();
                  },
                  child: ListView.builder(
                      itemCount: listNotifications.notifications.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        return NotificationMedals(Index: index);
                      }),
                ),
              ),
            ),
          );
  }

  AppBar AppbarBuild() {
    return AppBar(
      backgroundColor: Color(0xffF4F7FF),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Provider.of<ProviderNofitcition>(context, listen: false)
              .ListNofitcition
              .unreadCount = 0;
          ServiceNotificationsSeen().postNotificationsSeen();
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      title: Text(
        "الاشعارات",
        style: TextStyle(
         // fontSize: ScreenUtil().setSp(18),
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Container NotificationMedals({int Index}) {
    return Container(
      //alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * .95,
      //  height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 0)),
      child: Card(
        elevation: 2,
        color: !listNotifications.notifications[Index].seen
            ? Colors.white70
            : Color(0xffF4F7FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          //   mainAxisAlignment:MainAxisAlignment.spaceBetween ,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xffF4F7FF),
                  border: Border.all(width: 0, color: Color(0xffF2F4FF)),
                  borderRadius: BorderRadius.circular(40)),
              child: FaIcon(
                FontAwesomeIcons.bell,
                size: 40, //
                color: Color(0xffA4AEC6),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   child: Text(
                    //     "محادثة جديدة",
                    //     style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                    //   ),
                    //   alignment: Alignment.centerRight,
                    // ),
                    Container(
                        alignment: Alignment.centerRight,
                        child:
                            Text(listNotifications.notifications[Index].message,
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                              //    fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w600,
                                ))),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          listNotifications.notifications[Index].createdAt,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                         //     fontSize: ScreenUtil().setSp(18)
                         ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
