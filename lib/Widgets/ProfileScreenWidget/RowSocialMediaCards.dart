import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Model/usersApi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class RowSocialMediaCards extends StatelessWidget {

  SocialLinks socialLinks;


  RowSocialMediaCards({@required  this.socialLinks});


  String startTwitter ="https://twitter.com/";
  String startInstagram ="https://www.instagram.com/";
  String startFacebook ="https://www.facebook.com/";
  String startSnapchat ="https://www.snapchat.com/";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.09,
      margin: EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        //    color: BackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.twitter,
                color: Color(0xff21A9F4),
              ),
              onPressed: ()async {

                socialLinks.twitter == null?
                await canLaunch(startTwitter) ? await launch(startTwitter) : throw 'Could not launch':
                await canLaunch( socialLinks.twitter) ? await launch( socialLinks.twitter) :   BotToast.showText(
                  text: "The link is wrong, please modify the link".tr(),
                  contentColor: Colors.blue,
                );

              },
              iconSize: 30,
            ),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Color(0xffFFDD55),
                ),
                onPressed: () async{


                  socialLinks.instagram == null?
                  await canLaunch(startInstagram) ? await launch(startInstagram) : throw 'Could not launch':
                  await canLaunch( socialLinks.instagram ) ? await launch( socialLinks.instagram ) :   BotToast.showText(
                    text: "The link is wrong, please modify the link".tr(),
                    contentColor: Colors.blue,
                  );

                },
                iconSize: 30),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Color(0xff1977F2),
                ),
                //FFEB3B
                onPressed: () async{
                  socialLinks.facebook == null?
                  await canLaunch(startFacebook) ? await launch(startFacebook) : throw 'Could not launch':
                  await canLaunch(socialLinks.facebook) ? await launch(socialLinks.facebook) :    BotToast.showText(
                    text: "The link is wrong, please modify the link".tr(),
                    contentColor: Colors.blue,
                  );
                },
                iconSize: 30),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.snapchatGhost,
                  color: Color(0xffFFEB3B),
                ),
                onPressed: () async{
                  socialLinks.snapchat == null?
                  await canLaunch(startSnapchat) ? await launch(startSnapchat) : throw 'Could not launch':
                  await canLaunch(socialLinks.snapchat) ? await launch(socialLinks.snapchat) :   BotToast.showText(
                    text: "The link is wrong, please modify the link".tr(),
                    contentColor: Colors.blue,
                  );
                },
                iconSize: 30),
          ],
        ),
      ),
    );
  }
}
