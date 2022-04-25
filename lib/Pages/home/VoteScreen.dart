import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/AdvertismentsApi.dart';
import 'package:cv_sports/Model/VoteResult.dart';
import 'package:cv_sports/Model/voteApi.dart';
import 'package:cv_sports/Providers/AdvertismentsProvider.dart';
import 'package:cv_sports/Providers/VoteProvider.dart';
import 'package:cv_sports/Services/AllServices/ServiceMakeDynamiclink.dart';
import 'package:cv_sports/Services/AllServices/serviceQuestionVoteGet.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/CarouselAds.dart';
import 'package:cv_sports/Widgets/VoteScreenWidget/SelectVote.dart';
import 'package:cv_sports/Widgets/VoteScreenWidget/ViewVote.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:polls/polls.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:share/share.dart';

import '../../ProviderAll.dart';

class VoteScreen extends StatefulWidget {
  bool isDynamic;

  VoteScreen({this.isDynamic = false});

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  String sortValueFilter;

  VoteQuestion dataVote;
  VoteResult dataVoteResult;

  List<double> voteCount = [];
  bool doneGetVote = false;

  String user = "king@mail.com";
  int userChoice;
  Map usersWhoVoted = {};
  String creator = "eddy@mail.com";

  DynamicLinkParameters parameters;

  @override
  void initState() {
    Provider.of<VoteProvider>(context, listen: false).getVoteData();
    if (Provider.of<AdvertismentsProvider>(context, listen: false)
            .listAdvertisments
            .length ==
        0) {
      Provider.of<AdvertismentsProvider>(context, listen: false)
          .getAdvertismentsData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataVote = Provider.of<VoteProvider>(context).listVoteQuestion;
    dataVoteResult = Provider.of<VoteProvider>(context).listVoteResult;
    List<AdvertismentsApi> advertisments =
        Provider.of<AdvertismentsProvider>(context).listAdvertisments;
    if (dataVote != null && doneGetVote == false) {
      print("done");

      dataVote.answers.forEach((element) {
        voteCount.add(0.0);
      });
      print("voteCount = " + voteCount.toString());
      doneGetVote = true;
    }

    return Provider.of<VoteProvider>(context).loading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
        : Scaffold(
            backgroundColor: Color(0xffF9FAFF),
            appBar: AppBar(
              automaticallyImplyLeading: widget.isDynamic ? true : false,
              backgroundColor: Color(0xffF9FAFF),
              elevation: 0,
              title: Text(
                "Vote".tr(),
                style: TextStyle(
                //  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RowVoteCards(context: context, dataVote: dataVote),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CarouselAds(listAdvertisments: advertisments),
                    ],
                  ),
                )),
          );
  }

//=============================== Widget Row Posts Cards===========================

  Card RowVoteCards({BuildContext context, VoteQuestion dataVote}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              dataVote.question,
              style: TextStyle(
             //   fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: dataVoteResult == null
                  ? ListView.builder(
                      itemCount: dataVote.answers.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              if (BaseUrlApi.tokenUser == null) {
                                BotToast.showText(
                                  text:
                                      "The application must be registered first"
                                          .tr(),
                                  contentColor: Colors.blue,
                                );
                              } else {
                                print("Go");
                                ServiceQuestionVoteGet()
                                    .VoteResultAdd(
                                        idVote: dataVote.id,
                                        answerId: dataVote.answers[index].id
                                            .toString())
                                    .whenComplete(() {
                                  Provider.of<VoteProvider>(context,
                                          listen: false)
                                      .getVoteData();
                                });
                              }
                            },
                            child: SelectVote(
                              dataVote: dataVote,
                              index: index,
                            ));
                      })
                  : ListView.builder(
                      itemCount: dataVote.answers.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ViewVote(
                          index: index,
                          dataVote: dataVote,
                          dataVoteResult: dataVoteResult,
                        );
                      }),
            ),
            dataVoteResult != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment. ,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "عدد المصوتين :" +
                              dataVoteResult.totalAnswers.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () async {
                              DynamicLinkParameters parameters =
                                  DynamicLinkParameters(
                                uriPrefix: 'https://app.cvsportsapp.com',
                                link: Uri.parse(
                                    'https://app.cvsportsapp.com/VoteShare'),
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
                                socialMetaTagParameters:
                                    SocialMetaTagParameters(
                                  title: dataVote.question,
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
                            })
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
