import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cv_sports/Model/AdvertismentsApi.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CarouselAds extends StatefulWidget {

  final List<AdvertismentsApi> listAdvertisments;

  CarouselAds({@required this.listAdvertisments});
  @override
  _CarouselAdsState createState() => _CarouselAdsState();
}

class _CarouselAdsState extends State<CarouselAds> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(

          child: CarouselSlider.builder(
            itemCount:widget.listAdvertisments.length,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height * .23,
                aspectRatio: 16 / 9,
                viewportFraction: .80,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () async{
                  widget.listAdvertisments[index].link == null?
                  await canLaunch("https://www.google.com/") ? await launch("https://www.google.com/") : throw 'Could not launch':
                  await canLaunch( widget.listAdvertisments[index].link) ? await launch( widget.listAdvertisments[index].link) :   BotToast.showText(
                  text: "The link is wrong".tr(),
                  contentColor: Colors.blue,
                  );                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.listAdvertisments[index].image,
                      fit: BoxFit.fill,

                      // height: MediaQuery.of(context).size.height * .30,
                      width: MediaQuery.of(context).size.width,
                    )),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listAdvertisments.map((url) {
            int index = widget.listAdvertisments.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.only(bottom: 8, right: 5 ,top: 10),
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
    );
  }
}
