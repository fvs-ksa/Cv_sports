import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/AllPost.dart';
import 'package:cv_sports/Model/Comments.dart';
import 'package:cv_sports/Pages/Category/PlayerInfomation.dart';
import 'package:cv_sports/Providers/ProviderShowAllPosts.dart';
import 'package:cv_sports/Providers/ProviderShowComments.dart';
import 'package:cv_sports/Services/AllServices/ServicesComments/serviceShowComments.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowVideos.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:uuid/uuid.dart';

class OnePostScreenAllPostShare extends StatefulWidget {
int postId;

OnePostScreenAllPostShare({ this.postId});

  @override
  _OnePostScreenAllPostShareState createState() => _OnePostScreenAllPostShareState();
}

class _OnePostScreenAllPostShareState extends State<OnePostScreenAllPostShare> {
  TextEditingController textEditingController = TextEditingController();
  List<Comments> listGetComments;
  PusherClient pusher;
  List<AllPost> listGetPostsForUpdate;

  AllPost singlePost;
  //============ pusherGetComments ================
  pusherGetComments() {
    PusherOptions options = PusherOptions(
      host: BaseUrlApi.baseUrlSocket,
      wsPort: 6001,
      encrypted: false,
    );
    pusher = PusherClient(
      BaseUrlApi.baseUrlSocketAppKey,
      options,
      enableLogging: true,
    );
    try {
      Channel channel = pusher.subscribe(
        BaseUrlApi.SocketChannelComment + widget.postId.toString(),
      );

      channel.bind(BaseUrlApi.SocketEventComment, (e) {
        print("My Data = " + e.toString());
        Provider.of<ProviderShowComments>(context, listen: false)
            .getNewComments(dataResponse: e);
      });
    } on DioError catch (e) {
      debugPrint('${e.message}');
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProviderShowPosts>(context, listen: false)
        .getSinglePostData(postId: widget.postId);
    Provider.of<ProviderShowComments>(context, listen: false)
        .getCommentsData(idPost: widget.postId);
    pusherGetComments();
    
    
  }

  @override
  Widget build(BuildContext context) {
    listGetComments = Provider.of<ProviderShowComments>(context).listComments;
    singlePost = Provider.of<ProviderShowPosts>(context).singlePost;
    return Provider.of<ProviderShowComments>(context).loading ||
        Provider.of<ProviderShowPosts>(context).loading
        ? Scaffold(
      body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          )),
    )
        : GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
            Size.fromHeight(.11 * MediaQuery.of(context).size.height),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PlayerInformation(
                          userId: singlePost.userId,
                        );
                      }));
                    },
                    child: ImageAndTextProfile(context)),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xffFFFFFF),
        ), // color: Color(0xff5E5D8F),
        body: Container(
          color: Color(0xffF9FAFF),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: LazyLoadScrollView(
                  onEndOfPage: () {
                    print("Enter 1");
                    Provider.of<ProviderShowComments>(context,
                        listen: false)
                        .fetchCommentsApi(idPost: widget.postId);
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      MainPostCard(context),
                      ListView.builder(
                          shrinkWrap: true,
                          reverse: false,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: listGetComments.length,
                          itemBuilder: (context, indexComment) {
                            return OneComment(indexComment: indexComment);
                          }),
                    ],
                  ),
                ),
              ),
              singlePost.isCommentable &&
                  BaseUrlApi.tokenUser != null
                  ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: RowEditNewComment(context))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Column OneComment({@required int indexComment}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PlayerInformation(
                      userId: listGetComments[indexComment].userId,
                    );
                  }));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          listGetComments[indexComment].userAvatar,
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: Text(
                        listGetComments[indexComment].userName,
                        style: TextStyle(
                      //    fontSize: ScreenUtil().setSp(15)
                          ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.article_outlined,
                          color: Color(0xffC1C0D3),
                        ),
                        Text(
                          listGetComments[indexComment].created,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 25,
                      ),
                      child: Text(
                        listGetComments[indexComment].body,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                  //          fontSize: ScreenUtil().setSp(13),
                            color: Colors.black),
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Center ImageAndTextProfile(context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: .06 * MediaQuery.of(context).size.height,
            width: .125 * MediaQuery.of(context).size.width,
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                backgroundImage: NetworkImage(singlePost.userAvatar)),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            singlePost.userName,
            style: TextStyle(
       //         fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold
       ),
          ),
        ],
      ),
    );
  }

  Card MainPostCard(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Container(
          //   width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.article_outlined,
                    color: Color(0xffC1C0D3),
                  ),
                  Text(
                    singlePost.created,
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, bottom: 5),
                child: Text(
                  singlePost.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  maxLines: null,
                ),
              ),
              singlePost.media.isNotEmpty
                  ? Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * .22, //120

                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: singlePost.media.length,
                    itemBuilder: (context, indexMedia) {
                      return singlePost.media[indexMedia].type
                          .index ==
                          0
                          ? Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5),
                        child: FullScreenWidget(
                            backgroundColor: Colors.white,
                            child: Container(
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    .25,
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    .75,
                                child: InteractiveViewer(
                                  //  boundaryMargin: EdgeInsets.all(100),
                                  minScale: 0.1,
                                  // min scale
                                  maxScale: 4.6,
                                  // max scale
                                  scaleEnabled: true,
                                  panEnabled: true,

                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(25),
                                    child: Image.network(
                                      singlePost
                                          .media[indexMedia].path,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ))),
                      )
                          : RowVideos(
                          showTitle: false,
                          videoTitle: "",
                          videoUrl: singlePost.media[indexMedia].path);
                    }),
              )
                  : Container(),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidComment,
                          color: Color(0xff2C2B53),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(singlePost.commentCount.toString())
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if (BaseUrlApi.tokenUser == null) {
                          BotToast.showText(
                            text:
                            "The application must be registered first".tr(),
                            contentColor: Colors.blue,
                          );
                        } else {
                          setState(() {
                            singlePost.isLiked =
                            !singlePost.isLiked;
                            // Provider.of<ProviderShowPosts>(context,
                            //     listen: false)
                            //     .ChangeLikeSinglePost(index: widget.indexPost);
                            // if (singlePost.isLiked) {
                            //   singlePost.likeCount++;
                            //   Provider.of<ProviderShowPosts>(context,
                            //       listen: false)
                            //       .increasedSinglePost(index: widget.indexPost);
                            // } else {
                            //   singlePost.likeCount--;
                            //   Provider.of<ProviderShowPosts>(context,
                            //       listen: false)
                            //       .descreadSinglePost(index: widget.indexPost);
                            // }
                          });
                          await ServiceShowCommentsAndAllPosts()
                              .addLike(idPost: widget.postId);
                        }
                      },
                      child: Row(
                        children: [
                          Text(singlePost.likeCount.toString(),
                              style:
                              TextStyle(
                            //    fontSize: ScreenUtil().setSp(18)
                                )),
                          SizedBox(
                            width: 5,
                          ),
                          singlePost.isLiked
                              ? FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                          )
                              : FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Container RowEditNewComment(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Provider.of<ProviderShowComments>(context).loadingComment
          ? Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
          : Card(
        margin: EdgeInsets.all(0),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle:
                    TextStyle(fontSize: 18, color: Colors.grey),
                    hintText: "Write your message here".tr(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  Provider.of<ProviderShowComments>(context,
                      listen: false)
                      .changeLoading(newLoading: true);
                  await ServiceShowCommentsAndAllPosts()
                      .addComments(
                      idPost: widget.postId,
                      body: textEditingController.text.trim())
                      .then((v) {
                    if (v.statusCode == 401) {
                      BotToast.showText(
                        text: v.data["message"],
                        contentColor: Colors.blue,
                      );
                    }

                    textEditingController.clear();
                    Provider.of<ProviderShowComments>(context,
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

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      //  isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: ListTile(
                      trailing: Icon(Icons.arrow_back_outlined),
                      title: Text(
                        "غلق التعليقات",
                        style: TextStyle(
                    //        fontSize: ScreenUtil().setSp(18),
                            color: Colors.grey.shade700),
                      ),
                      leading: FaIcon(
                        FontAwesomeIcons.checkSquare,
                        color: Color(0xffC1C0D3),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: ListTile(
                      trailing: Icon(Icons.arrow_back_outlined),
                      title: Text(
                        "تعديل المنشور",
                        style: TextStyle(
                       //     fontSize: ScreenUtil().setSp(18),
                            color: Colors.grey.shade700),
                      ),
                      leading: FaIcon(
                        FontAwesomeIcons.edit,
                        color: Color(0xffC1C0D3),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: ListTile(
                      trailing: Icon(Icons.arrow_back_outlined),
                      title: Text(
                        "Delete post".tr(),
                        style: TextStyle(
                       //     fontSize: ScreenUtil().setSp(18),
                            color: Colors.grey.shade700),
                      ),
                      leading: FaIcon(
                        FontAwesomeIcons.trashAlt,
                        color: Color(0xff6EC9F1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //=================== dispose ===============

  close() async {
    await pusher.unsubscribe(
      BaseUrlApi.SocketChannelComment + widget.postId.toString(),
    );

    // echo.disconnect();
    await pusher.disconnect();

    //  super.dispose();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }
}
