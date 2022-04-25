import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/AllPost.dart';
import 'package:cv_sports/Pages/Category/PlayerInfomation.dart';
import 'package:cv_sports/Pages/PagesProfileScreen/OnePostScreenProfile.dart';
import 'package:cv_sports/Pages/SubScreen/OnePostScreenAllPost.dart';
import 'package:cv_sports/Providers/ProviderShowAllPosts.dart';
import 'package:cv_sports/Services/AllServices/ServiceMakeDynamiclink.dart';
import 'package:cv_sports/Services/AllServices/ServicesComments/serviceShowComments.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowVideos.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class PostsScreen extends StatefulWidget {
  bool isDynamic;

  PostsScreen({this.isDynamic = false});
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<AllPost> listGetPosts;
  @override
  void initState() {
    super.initState();

    Provider.of<ProviderShowPosts>(context, listen: false).getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    listGetPosts = Provider.of<ProviderShowPosts>(context).listAllPosts;

    return Provider.of<ProviderShowPosts>(context).loading
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            )),
          )
        : Scaffold(
            backgroundColor: Color(0xffF9FAFF),
            appBar: AppBar(
              automaticallyImplyLeading: widget.isDynamic ? true : false,
              backgroundColor: Color(0xffF9FAFF),
              elevation: 0,
              title: Text(
                "Publications".tr(),
                style: TextStyle(
                //  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: LazyLoadScrollView(
              onEndOfPage: () {
                Provider.of<ProviderShowPosts>(context, listen: false)
                    .fetchPostsApi();
              },
              child: ListView.builder(
                itemCount: listGetPosts.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return OnePostScreenAllPost(
                          indexPost: index,
                          listAllPosts: listGetPosts[index],
                        );
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: RowPostsCards(context: context, index: index)),
                  );
                },
              ),
            ),
          );
  }

//=============================== Widget Row Posts Cards===========================

  Card RowPostsCards({BuildContext context, int index}) {
    print("listGetPosts[index] = " + listGetPosts[index].isLiked.toString());
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PlayerInformation(
                      userId: listGetPosts[index].userId,
                    );
                  }));
                },
                child: ImageAndTextProfile(index: index)),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return OnePostScreenAllPost(
                    indexPost: index,
                    listAllPosts: listGetPosts[index],
                  );
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        color: Color(0xffC1C0D3),
                      ),
                      Text(
                        listGetPosts[index].created,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
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
                    textAlign: TextAlign.justify,
                    text: listGetPosts[index].body,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600),
                    linkStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //     right: 0,
                  //   ),
                  //   child: Text(
                  //     listGetPosts[index].body,
                  //     textAlign: TextAlign.justify,
                  //     style: TextStyle(
                  //       fontSize: ScreenUtil().setSp(18),
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            listGetPosts[index].media.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * .23, //120

                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listGetPosts[index].media.length,
                        itemBuilder: (context, indexMedia) {
                          return listGetPosts[index]
                                      .media[indexMedia]
                                      .type
                                      .index ==
                                  0
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: FullScreenWidget(
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width: MediaQuery.of(context).size.width *
                                          .75,
                                      child: InteractiveViewer(
                                        //   boundaryMargin: EdgeInsets.all(100),
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
                                            listGetPosts[index]
                                                .media[indexMedia]
                                                .path,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : RowVideos(
                                  showTitle: false,
                                  videoTitle: "",
                                  videoUrl: listGetPosts[index]
                                      .media[indexMedia]
                                      .path,
                                );
                        }),
                  )
                : Container(),
            Divider(
              thickness: 2,
            ),
            Row(
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
                      listGetPosts[index].commentCount.toString(),
                      style: TextStyle(
                      //  fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    if (BaseUrlApi.tokenUser == null) {
                      BotToast.showText(
                        text: "The application must be registered first".tr(),
                        contentColor: Colors.blue,
                      );
                    } else {
                      setState(() {
                        listGetPosts[index].isLiked =
                            !listGetPosts[index].isLiked;
                        if (listGetPosts[index].isLiked) {
                          listGetPosts[index].likeCount++;
                        } else {
                          listGetPosts[index].likeCount--;
                        }
                      });

                      await ServiceShowCommentsAndAllPosts()
                          .addLike(idPost: listGetPosts[index].id);
                    }

                    // Provider.of<ProviderShowPosts>(context, listen: false)
                    // //    .getPostsData();
                  },
                  child: Row(
                    children: [
                      Text(listGetPosts[index].likeCount.toString(),
                          style: TextStyle(
                         //   fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      listGetPosts[index].isLiked
                          ? FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            )
                          : FaIcon(
                              FontAwesomeIcons.heart,
                              color: Colors.black,
                            ),
                      IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () async {
                            DynamicLinkParameters parameters =
                                DynamicLinkParameters(
                              uriPrefix: 'https://app.cvsportsapp.com',

                              link: Uri.parse(
                                  'https://app.cvsportsapp.com/PostShare?PostId=${listGetPosts[index].id}'), //${listGetPosts[index].id}
                              androidParameters: AndroidParameters(
                                packageName: 'com.alexapps.cv_sports',
                                minimumVersion: 0,
                              ),
                              dynamicLinkParametersOptions:
                                  DynamicLinkParametersOptions(
                                shortDynamicLinkPathLength:
                                    ShortDynamicLinkPathLength.short,
                              ),
                              iosParameters: IosParameters(
                                  bundleId: 'com.alexapps.cv_sports',
                                  minimumVersion: '1.0.0',
                                  appStoreId: '1559428912'),

                              socialMetaTagParameters: SocialMetaTagParameters(
                                title: listGetPosts[index].body,
                                description: "",
                                imageUrl: Uri.parse(
                                    'https://cvsportsapp.com/img/logo.f8292100.png'),
                              ),
                            );
                            final ShortDynamicLink shortDynamicLink =
                                await parameters.buildShortLink();
                            final Uri shortUrl = shortDynamicLink.shortUrl;
                            print(shortUrl);
                            ServiceMakeDynamiclink().postMakeDynamiclink(
                                dynamicLink: shortUrl.toString());
                            Share.share('$shortUrl');

                            // await parameters.buildUrl().then((value) {
                            //   print("DynamicLinkParameters = "+value.data.contentText);
                            // });
                          })
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //======================= Widget Image And Text Profile ==============================
  Container ImageAndTextProfile({@required int index}) {
    return Container(
      //  margin: EdgeInsets.only(right: 5, left: 5),
      child: Row(
        children: [
          Container(
            height: .06 * MediaQuery.of(context).size.height,
            width: .125 * MediaQuery.of(context).size.width,
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                backgroundImage: NetworkImage(listGetPosts[index].userAvatar)),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            listGetPosts[index].userName,
            style: TextStyle(
              //  fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.bold
               ),
          ),
        ],
      ),
    );
  }
}
