import 'package:cv_sports/Model/GetRooms.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/OneChatScreen.dart';
import 'package:cv_sports/Services/AllServices/ServicesChat/ServicesChat.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyConversationProfileScreen extends StatefulWidget {
  int myProfileId;

  MyConversationProfileScreen({@required this.myProfileId});

  @override
  _MyConversationProfileScreenState createState() =>
      _MyConversationProfileScreenState();
}

class _MyConversationProfileScreenState
    extends State<MyConversationProfileScreen> {
  var futureGetRoom;
  GetRooms allRooms;
  bool isRoomOther;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseUrlApi.tokenUser == null
        ? Card(
            elevation: 3,
            child: Text(
              "The application must be registered first".tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : FutureBuilder(
            future: BaseUrlApi.idUser == widget.myProfileId
                ? fetchRoomApi()
                : fetchRoomOtherApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                return allRooms.rooms.length == 0
                    ? Center(
                        child: Card(
                        elevation: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sorry, no conversation has occurred.".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BaseUrlApi.idUser == widget.myProfileId
                                ? Container()
                                : BottomApp(
                                    title: "New conversation appeared".tr(),
                                    setCircular: 10,
                                    functionButton: () async {
                                      await ServiceChat()
                                          .startRoom(idUser: widget.myProfileId)
                                          .whenComplete(() {
                                        setState(() {
                                          futureGetRoom;
                                        });
                                      });
                                    },
                                    setWidth: .8,
                                    oneColor: Color(0xff2C2B53),
                                    twoColor: Color(0xff2C2B53),
                                    colorTitle: Colors.white,
                                  ),
                          ],
                        ),
                      ))
                    : ListView.builder(
                        itemCount: allRooms.rooms.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: RowChatsCards(index: index));
                        });
              }
            });
  }

//============== RowChatsCards ==============
  Center RowChatsCards({int index}) {
    print("length " + allRooms.rooms.length.toString());
    // print("myProfileId "+widget.myProfileId.toString());
    //  allRooms.rooms[index].members.forEach((element ) {
    //    print(element.id.toString() + element.name );
    //
    //  });
    //  allRooms.rooms[index].members.contains(element)

    return Center(
      child: Stack(
        //   fit: StackFit.passthrough,
        alignment: AlignmentDirectional.topEnd,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OneChatScreen(
                      myProfileId: widget.myProfileId,
                      allRooms: allRooms.rooms[index],
                      isRoomOther: isRoomOther,
                    );
                  }));
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        //  SizedBox(width: 20,),
                        Flexible(
                          flex: 2,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                allRooms.rooms[index].members
                                    .singleWhere((element) =>
                                        element.id != widget.myProfileId)
                                    .avatar,
                                fit: BoxFit.fill,
                                height:
                                    MediaQuery.of(context).size.height * .15,
                                width: MediaQuery.of(context).size.width * .42,
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      allRooms.rooms[index].members
                                          .singleWhere((element) =>
                                              element.id != widget.myProfileId)
                                          .name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      allRooms.rooms[index].lastMessage != null
                                          ? allRooms
                                              .rooms[index].lastMessage.created
                                          : "",
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.home),
                                  Text(
                                    allRooms.rooms[index].members
                                        .singleWhere((element) =>
                                            element.id != widget.myProfileId)
                                        .role,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                allRooms.rooms[index].lastMessage != null
                                    ? BaseUrlApi.idUser != widget.myProfileId
                                        ? allRooms.rooms[index].members
                                                    .singleWhere((element) =>
                                                        element.id !=
                                                        widget.myProfileId)
                                                    .seen ==
                                                1
                                            ? allRooms.rooms[index].lastMessage
                                                .message
                                            : "لديك رسالة جديدة"
                                        : allRooms.rooms[index].members
                                                    .singleWhere((element) =>
                                                        element.id ==
                                                        widget.myProfileId)
                                                    .seen ==
                                                1
                                            ? allRooms.rooms[index].lastMessage
                                                .message
                                            : "لديك رسالة جديدة"
                                    : "لا يوجد رسائل",
                                textAlign: TextAlign.right,
                                style: allRooms.rooms[index].lastMessage != null
                                    ? BaseUrlApi.idUser != widget.myProfileId
                                        ? allRooms.rooms[index].members
                                                    .singleWhere((element) =>
                                                        element.id !=
                                                        widget.myProfileId)
                                                    .seen ==
                                                1
                                            ? TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade700)
                                            : TextStyle(
                                                fontSize: 16, color: Colors.red)
                                        : allRooms.rooms[index].members
                                                    .singleWhere((element) =>
                                                        element.id ==
                                                        widget.myProfileId)
                                                    .seen ==
                                                1
                                            ? TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade700)
                                            : TextStyle(
                                                fontSize: 16, color: Colors.red)
                                    : TextStyle(
                                        fontSize: 16, color: Colors.red),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          BaseUrlApi.idUser != widget.myProfileId
              ? allRooms.rooms[index].members
                          .singleWhere(
                              (element) => element.id != widget.myProfileId)
                          .seen ==
                      1
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.transparent,
                      child: Container(),
                    )
                  : Icon(
                      Icons.message,
                      color: Color(0xff2C2B53),
                    )
              : allRooms.rooms[index].members
                          .singleWhere(
                              (element) => element.id == widget.myProfileId)
                          .seen ==
                      1
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.transparent,
                      child: Container(),
                    )
                  : allRooms.rooms[index].lastMessage == null
                      ? CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.transparent,
                          child: Container(),
                        )
                      : Icon(
                          Icons.message,
                          color: Color(0xff2C2B53),
                        )
        ],
      ),
    );
  }

//============== RowChatsCards ==============

  Future<void> fetchRoomApi() async {
    print("fetchRoomApi");
    isRoomOther = false;
    Response response = await ServiceChat().showMyRooms();

    if (response.statusCode == 200) {
      allRooms = GetRooms.fromJson(response.data);
    }
  }

  Future<void> fetchRoomOtherApi() async {
    isRoomOther = true;
    Response response =
        await ServiceChat().showOtherRoom(idUser: widget.myProfileId);

    if (response.statusCode == 200) {
      print("allRooms 1= " + allRooms.toString());
      allRooms = GetRooms.fromJson(response.data);
      print("allRooms 2 = " + allRooms.toString());
    }
  }
}
