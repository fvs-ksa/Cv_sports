import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cv_sports/Model/NewsApi.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowVideos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class OneNewsScreen extends StatefulWidget {
  NewsApi showNews;

  OneNewsScreen({@required this.showNews});

  @override
  _OneNewsScreenState createState() => _OneNewsScreenState();
}

class _OneNewsScreenState extends State<OneNewsScreen> {
  int _current = 0;
  bool isVideo = false;
  @override
  void initState() {
    widget.showNews.image.forEach((element) {
      if (element.type == "video") {
        setState(() {
          isVideo = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFBFF),
      appBar: AppBar(
        backgroundColor: Color(0xffFAFBFF),
        centerTitle: true,
        elevation: 0,
        title: Text("News details".tr(),
            style: TextStyle(
              //  fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.w600
               )
                ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              carouselNews(),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(widget.showNews.clubIcon,
                            fit: BoxFit.fill, height: 30, width: 30),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.showNews.clubName,
                          style: TextStyle(
                           //   fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 3),
                        child: Text(
                          widget.showNews.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                            //  fontSize: ScreenUtil().setSp(18)
                              ),
                        )),
                    isVideo
                        ? Container(
                            height: MediaQuery.of(context).size.height * .32,
                            child: RowVideos(
                              showTitle: false,
                              videoTitle: "",
                              videoUrl: widget.showNews.image
                                  .singleWhere(
                                      (element) => element.type == "video")
                                  .path,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Linkify(
                            softWrap: true,
                            onOpen: (link) async {
                              if (await canLaunch(link.url)) {
                                await launch(link.url);
                              } else {
                                throw 'Could not launch $link';
                              }
                            },
                            textAlign: TextAlign.right,
                            text: widget.showNews.content,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                            linkStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          )
                          // AutoSizeText(
                          //   widget.showNews.content.trim(),textAlign: TextAlign.justify,
                          //   style: TextStyle(fontSize: 18 , color: Colors.black45,),
                          //   maxLines: null,
                          // )
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //=============================== Widget Carousel News ===========================

  Container carouselNews() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: widget.showNews.image
                .where((element) => element.type != "video")
                .length,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height * .23,
                //    aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: .85,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            itemBuilder: (ctx, index) {
              return FullScreenWidget(
                  backgroundColor: Colors.white,
                  child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width * .80,
                      child: InteractiveViewer(
                        //     boundaryMargin: EdgeInsets.all(100),
                        minScale: 0.1,
                        // min scale
                        maxScale: 4.6,
                        // max scale
                        scaleEnabled: true,
                        panEnabled: true,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.showNews.image
                                        .where((element) =>
                                            element.type != "video")
                                        .length ==
                                    0
                                ? widget.showNews.clubIcon
                                : widget.showNews.image[index].path,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.showNews.image.map((url) {
              int index = widget.showNews.image.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.only(bottom: 8, right: 5, top: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
