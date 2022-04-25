import 'package:cv_sports/Model/usersApi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:uuid/uuid.dart';

class MyImagesDataProfile extends StatelessWidget {


  Users informationProfile;

  MyImagesDataProfile({@required  this.informationProfile  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF9FAFF),
      appBar: AppBar(
        backgroundColor: Color(0xffF9FAFF),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Photo Gallery".tr() + " - ",
              style: TextStyle(
           //     fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              informationProfile.name,
              style: TextStyle(
         //       fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: GridImages(),
    );
  }

  GridView GridImages() {
    return GridView.builder(
      itemCount:  informationProfile.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 20.0, mainAxisSpacing: 16.0),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyGallaryImages(
                  informationProfile: informationProfile,
                  currentIndex: index,
                ),
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Image.network(
                  informationProfile.images[index].path,
                  fit: BoxFit.fill,
                )),
          ),
        );
      },
    );
  }
}

class MyGallaryImages extends StatefulWidget {
  MyGallaryImages(
      {@required this.currentIndex, @required this.informationProfile});

  int currentIndex;
  Users informationProfile;

  @override
  _MyGallaryImagesState createState() => _MyGallaryImagesState();
}

class _MyGallaryImagesState extends State<MyGallaryImages> {
  void onPageChanged(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions.customChild(
            child: Image.network(
              widget.informationProfile.images[widget.currentIndex].path,
            ),
            //    imageProvider: NetworkImage(informationProfile.images[index].path),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: Uuid().v4()),
          );
        },
        itemCount: widget.informationProfile.images.length,
        loadingBuilder: (context, event) => Center(),
        backgroundDecoration: BoxDecoration(color: Colors.transparent),
        //   pageController: PageController(initialPage: widget.currentIndex),
        onPageChanged: onPageChanged,
      ),
    );
  }
}
