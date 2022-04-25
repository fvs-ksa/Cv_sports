import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/OnePostScreenProfile.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Providers/UserInformationProvider.dart';
import 'package:cv_sports/Services/AllServices/ServicesComments/serviceShowComments.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowVideos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';

//import 'package:laravel_echo/laravel_echo.dart';
//import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class MyPostsProfileScreen extends StatefulWidget {
  Users informationProfile;

  MyPostsProfileScreen({@required this.informationProfile});

  @override
  _MyPostsProfileScreenState createState() => _MyPostsProfileScreenState();
}

class _MyPostsProfileScreenState extends State<MyPostsProfileScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.informationProfile.id == BaseUrlApi.idUser) {
      widget.informationProfile =
          Provider.of<InformationMyProfileProvider>(context)
              .listInformationUser;
    } else {
      widget.informationProfile =
          Provider.of<UserInformationProvider>(context).listInformationUser;
    }

    return widget.informationProfile.posts.length == 0
        ? Center(
            child: Card(
              elevation: 3,
              child: Text(
                "Sorry, there is currently no post that has been published."
                    .tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView.builder(
            itemCount: widget.informationProfile.posts.length,
            padding: EdgeInsets.symmetric(horizontal: 5),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return OnePostScreenProfile(
                        userId: widget.informationProfile.id,
                        indexPost: index,
                        postId: widget.informationProfile.posts[index].id,
                      );
                    }));
                  },
                  child: RowPostsCards(context, index));
            });
  }

  Column RowPostsCards(BuildContext context, int index) {
    return Column(
      children: [
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      widget.informationProfile.posts[index].created,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),

                Linkify(
                  softWrap: true,
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  textAlign: TextAlign.center,
                  text: widget.informationProfile.posts[index].body,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                  linkStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(right: 0, bottom: 5),
                //   child: Text(
                //     widget.informationProfile.posts[index].body,
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontSize: 18),
                //     maxLines: null,
                //   ),
                // ),
                widget.informationProfile.posts[index].media.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * .20, //120

                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget
                                .informationProfile.posts[index].media.length,
                            itemBuilder: (context, indexMedia) {
                              return widget.informationProfile.posts[index]
                                          .media[indexMedia].type.index ==
                                      0
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: FullScreenWidget(
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                                //      boundaryMargin: EdgeInsets.all(100),
                                                minScale: 0.1,
                                                // min scale
                                                maxScale: 4.6,
                                                // max scale
                                                scaleEnabled: true,
                                                panEnabled: true,

                                                child: Image.network(
                                                  widget
                                                      .informationProfile
                                                      .posts[index]
                                                      .media[indexMedia]
                                                      .path,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              )),
                                        ),
                                      ),
                                    )
                                  : RowVideos(
                                      showTitle: false,
                                      videoTitle: "",
                                      videoUrl: widget.informationProfile
                                          .posts[index].media[indexMedia].path,
                                    );
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
                          Text(
                              widget
                                  .informationProfile.posts[index].commentCount
                                  .toString(),
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          if (BaseUrlApi.tokenUser == null) {
                            BotToast.showText(
                              text: "The application must be registered first"
                                  .tr(),
                              contentColor: Colors.blue,
                            );
                          } else {
                            setState(() {
                              widget.informationProfile.posts[index].isLiked =
                                  !widget
                                      .informationProfile.posts[index].isLiked;
                              if (widget
                                  .informationProfile.posts[index].isLiked) {
                                widget.informationProfile.posts[index]
                                    .likeCount++;
                              } else {
                                widget.informationProfile.posts[index]
                                    .likeCount--;
                              }
                            });
                            await ServiceShowCommentsAndAllPosts().addLike(
                                idPost:
                                    widget.informationProfile.posts[index].id);
                          }

                          // if(informationProfile .id == BaseUrlApi.idUser){
                          //   Provider.of<InformationMyProfileProvider>(context, listen: false)
                          //       .getInformationMyProfileData();
                          // }else{
                          //   Provider.of<UserInformationProvider>(context,
                          //       listen: false)
                          //       .getInformationUser(
                          //       userId: informationProfile.id);
                          //
                          // }
                        },
                        child: Row(
                          children: [
                            Text(
                              widget.informationProfile.posts[index].likeCount
                                  .toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            widget.informationProfile.posts[index].isLiked
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
          ),
        ),
      ],
    );
  }
}
