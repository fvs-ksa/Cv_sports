import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/SubScreen/MyImagesDataProfile.dart';
import 'package:cv_sports/gallery/gallery_example.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uuid/uuid.dart';

class CardMyImagesUser extends StatelessWidget {

  Users informationProfile;

  CardMyImagesUser({@required  this.informationProfile  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * .25,
      decoration: BoxDecoration(
        //    color: BackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [

            ( informationProfile.images.length !=0?
            Expanded(
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: informationProfile.images.length,
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context, index) {
                      return  GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GalleryPhotoViewWrapper(
                                galleryItems: informationProfile.images,
                                initialIndex: index,
                              ),
                            ),
                          );
                        },
                        child: Container(

                            margin:EdgeInsets.symmetric(horizontal: 5 ,vertical: 10) ,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 0, color: Colors.white),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height *
                                        .25,

                                child: Image.network(
                                  informationProfile.images[index].path,
                                        fit: BoxFit.contain,
                                      ))),
                            );
                          }),
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Text(
                    "There are no pictures at the moment".tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )))),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return GalleryExample(
                    informationProfile: informationProfile,
                  );
                }));

                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return MyImagesDataProfile(
                //     informationProfile: informationProfile,
                //   );
                // }));
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                    color: Color(0xff2C2B53),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                //         height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text( informationProfile.images.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
