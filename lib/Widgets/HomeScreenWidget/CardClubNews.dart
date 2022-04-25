import 'dart:math';

import 'package:cv_sports/Model/NewsApi.dart';
import 'package:cv_sports/Pages/News/AllNewsScreen.dart';
import 'package:cv_sports/Pages/News/OneNewsScreen.dart';
import 'package:cv_sports/Providers/NewsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../newsCards.dart';
import 'package:easy_localization/easy_localization.dart';

class CardClubNews extends StatefulWidget {
  @override
  _CardClubNewsState createState() => _CardClubNewsState();
}

class _CardClubNewsState extends State<CardClubNews> {
  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).getNewsData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NewsApi> listNews = Provider.of<NewsProvider>(context).listNews;
    return Provider.of<NewsProvider>(context).loading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
        : Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: min(listNews.length, 2),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              child: NewsCard(
                                  mainImage:
                                      listNews[index].image[0].type == "video"
                                          ? listNews[index].clubIcon
                                          : listNews[index].image[0].path,
                                  iconClub: listNews[index].clubIcon,
                                  nameClub: listNews[index].clubName,
                                  contentNews: listNews[index].content,
                                  titleNews: listNews[index].title),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return OneNewsScreen(
                                    showNews: listNews[index],
                                  );
                                }));
                              },
                            ),
                            index == 0
                                ? Divider(
                                    height: 15,
                                    thickness: 2,
                                  )
                                : Container()
                          ],
                        );
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    height: MediaQuery.of(context).size.height * .06,
                    margin: EdgeInsets.only(bottom: 10),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AllNewsScreen(listNews: listNews);
                        }));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Color(0xff2C2B53),
                      child: Text(
                        "Club news".tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
