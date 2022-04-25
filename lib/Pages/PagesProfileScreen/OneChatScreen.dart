import 'dart:developer';

import 'package:cv_sports/Model/GetMassages.dart';
import 'package:cv_sports/Model/GetRooms.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Providers/CommentsChatProviuder.dart';
import 'package:cv_sports/Services/AllServices/ServicesChat/ServicesChat.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble/bubble.dart';

//import 'package:laravel_echo/laravel_echo.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pusher_client/pusher_client.dart';

class OneChatScreen extends StatefulWidget {
  int myProfileId;
  Room allRooms;
  bool isRoomOther;
  OneChatScreen(
      {@required this.myProfileId,
      @required this.allRooms,
      @required this.isRoomOther});

  @override
  _OneChatScreenState createState() => _OneChatScreenState();
}

class _OneChatScreenState extends State<OneChatScreen> {
  TextEditingController textEditingController = TextEditingController();

  GetMassages allMassage;
  PusherClient pusherClient;

  pusherGetComments() {
    PusherOptions options = PusherOptions(
      host: BaseUrlApi.baseUrlSocket,
      wsPort: 6001,
      //port: 6001,
      encrypted: false,
      auth: PusherAuth(
        'https://${BaseUrlApi.baseUrl}/laravel/broadcasting/auth',
        headers: BaseUrlApi().getHeaderWithInTokenChat(),
      ),
    );

    pusherClient = PusherClient(
      BaseUrlApi.baseUrlSocketAppKey,
      options,
      enableLogging: true,
    );

    try {
      Channel channel = pusherClient.subscribe(
          BaseUrlApi.SocketChannelChat + widget.allRooms.id.toString());

      channel.bind(BaseUrlApi.SocketEventChat, (e) {
        Provider.of<CommentsChatProvider>(context, listen: false)
            .getNewMassages(dataResponse: e);
      });
    } on DioError catch (e) {
      print("Error Here");
      debugPrint('${e.message}');
    }
  }

  @override
  void initState() {
    super.initState();
    pusherGetComments();
    Provider.of<CommentsChatProvider>(context, listen: false)
        .getMassageData(allRoomsId: widget.allRooms.id);
  }

  //=================== dispose ===============
  @override
  void dispose() {
    pusherClient.unsubscribe(
        BaseUrlApi.SocketChannelChat + widget.allRooms.id.toString());
    pusherClient.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allMassage = Provider.of<CommentsChatProvider>(context).allMassages;

    return Provider.of<CommentsChatProvider>(context).loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : WillPopScope(
      onWillPop: ()  async{
       await  ServiceChat().seenNewMessage(idRoom: widget.allRooms.id);
        Navigator.pop(context);
        return null;
      },
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Scaffold(
                backgroundColor: Color(0xffF9FAFF), //F9FAFF
                body: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      CardTopChat(context),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 20, left: 10, right: 10, top: 20),
                          child: LazyLoadScrollView(
                            onEndOfPage: () {
                              print("Enter 3");
                              Provider.of<CommentsChatProvider>(context,
                                      listen: false)
                                  .fetchMassageApi(
                                      allRoomsId: widget.allRooms.id);
                            },
                            child: ListView.builder(
                                itemCount: allMassage.messages.length,
                                shrinkWrap: true,
                                reverse: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Massages(index: index);
                                }),
                          ),
                        ),
                      ),
                      RowEditNewComment(context)
                    ],
                  ),
                ),
              ),
            ),
        );
  }

  Card CardTopChat(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        child: Column(
          children: [
            ListTile(
              trailing: IconButton(
                icon: EasyLocalization.of(context).locale.languageCode == "ar"
                    ? FaIcon(FontAwesomeIcons.arrowLeft,
                        color: Color(0xff2C2B53))
                    : FaIcon(FontAwesomeIcons.arrowRight,
                        color: Color(0xff2C2B53)),
                onPressed: () {
                  ServiceChat().seenNewMessage(idRoom: widget.allRooms.id);
                  Navigator.pop(context);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.isRoomOther
                            ? widget.allRooms.members
                                .singleWhere((element) =>
                                    element.id == widget.myProfileId)
                                .name
                            : widget.allRooms.members
                                .singleWhere((element) =>
                                    element.id != widget.myProfileId)
                                .name,
                        // textAlign:TextAlign.left ,
                        style: TextStyle(
                      //    fontSize: ScreenUtil().setSp(18),
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.isRoomOther
                            ? widget.allRooms.members
                                .singleWhere((element) =>
                                    element.id == widget.myProfileId)
                                .role
                            : widget.allRooms.members
                                .singleWhere((element) =>
                                    element.id != widget.myProfileId)
                                .role,
                        style: TextStyle(
                 //         fontSize: ScreenUtil().setSp(16),
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        widget.isRoomOther
                            ? widget.allRooms.members
                                .singleWhere((element) =>
                                    element.id == widget.myProfileId)
                                .avatar
                            : widget.allRooms.members
                                .singleWhere((element) =>
                                    element.id != widget.myProfileId)
                                .avatar,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column Massages({int index}) {
    return Column(
      children: [
        Bubble(
          // Color.fromRGBO(225, 255, 199, 1.0)
          margin: BubbleEdges.only(top: 20),
          padding: BubbleEdges.symmetric(horizontal: 40),
          alignment: widget.isRoomOther
              ? allMassage.messages[index].sender.id == widget.myProfileId
                  ? Alignment.topLeft
                  : Alignment.topRight
              : allMassage.messages[index].sender.id == widget.myProfileId
                  ? Alignment.topRight
                  : Alignment.topLeft,
          nip: widget.isRoomOther
              ? allMassage.messages[index].sender.id == widget.myProfileId
                  ? BubbleNip.leftTop
                  : BubbleNip.rightTop
              : allMassage.messages[index].sender.id == widget.myProfileId
                  ? BubbleNip.rightTop
                  : BubbleNip.leftTop,
          color: widget.isRoomOther
              ? allMassage.messages[index].sender.id == widget.myProfileId
                  ? Colors.white
                  : Color.fromRGBO(225, 255, 199, 1.0)
              : allMassage.messages[index].sender.id == widget.myProfileId
                  ? Color.fromRGBO(225, 255, 199, 1.0)
                  : Colors.white,
          child: Text(allMassage.messages[index].message,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              )),
        ),
        Container(
            alignment: widget.isRoomOther
                ? allMassage.messages[index].sender.id == widget.myProfileId
                    ? Alignment.centerLeft
                    : Alignment.centerRight
                : allMassage.messages[index].sender.id == widget.myProfileId
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: Text(
              allMassage.messages[index].created,
              style: TextStyle(
                color: Color(0xff767676),
        //        fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
              ),
            ))
      ],
    );
  }

  Container RowEditNewComment(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Provider.of<CommentsChatProvider>(context).loadingMassage
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ))
          : Card(
              // color: Colors.white,
              margin: EdgeInsets.all(0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(
                        //    fontSize: ScreenUtil().setSp(22),
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        controller: textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                //              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          hintText: "Write your message here".tr(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: Color(0xff2C2B53)),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        Provider.of<CommentsChatProvider>(context,
                                listen: false)
                            .changeLoading(newLoading: true);
                        await ServiceChat()
                            .addNewMessage(
                                massagesBody: textEditingController.text.trim(),
                                idRoom: widget.allRooms.id)
                            .whenComplete(() {
                          textEditingController.clear();
                          Provider.of<CommentsChatProvider>(context,
                                  listen: false)
                              .changeLoading(newLoading: false);
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
