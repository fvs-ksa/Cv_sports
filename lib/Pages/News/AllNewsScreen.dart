import 'package:cv_sports/Model/NewsApi.dart';
import 'package:cv_sports/Providers/NewsProvider.dart';
import 'package:cv_sports/Widgets/newsCards.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'OneNewsScreen.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class AllNewsScreen extends StatelessWidget {
  List<NewsApi> listNews;

  AllNewsScreen({@required this.listNews});

  @override
  Widget build(BuildContext context) {
    List<NewsApi> listNews = Provider.of<NewsProvider>(context).listNews;

    //  print((listNews[0].image.firstWhere((element) => element.type != "video")) ==null);

    //  print(listNews[0].image.firstWhere((element) => element.type != "video"));

    return Scaffold(
      backgroundColor: Color(0xffE4E8F2),
      appBar: AppBar(
        backgroundColor: Color(0xffE4E8F2),
        centerTitle: true,
        elevation: 0,
        title: Text("News".tr()),
      ),
      body: LazyLoadScrollView(
        onEndOfPage: () {
          Provider.of<NewsProvider>(context, listen: false).fetchNews();
        },
        child: ListView.builder(
            itemCount: listNews.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OneNewsScreen(
                      showNews: listNews[index],
                    );
                  }));
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    child: NewsCard(
                        mainImage: listNews[index].image[0].type == "video"
                            ? listNews[index].clubIcon
                            : listNews[index].image[0].path,
                        iconClub: listNews[index].clubIcon,
                        nameClub: listNews[index].clubName,
                        contentNews: listNews[index].content,
                        titleNews: listNews[index].title),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
