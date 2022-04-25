import 'package:cv_sports/Model/usersApi.dart';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:uuid/uuid.dart';

import 'package:easy_localization/easy_localization.dart';

class GalleryExample extends StatefulWidget {
  Users informationProfile;

  GalleryExample({@required this.informationProfile});

  @override
  _GalleryExampleState createState() => _GalleryExampleState();
}

class _GalleryExampleState extends State<GalleryExample> {
  bool verticalGallery = false;

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
              //style: TextStyle(fontSize: ScreenUtil().setSp(18)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.informationProfile.name,
              //style: TextStyle(fontSize: ScreenUtil().setSp(18)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.informationProfile.images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: .8),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                open(context, index);
              },
              child: Container(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        //      height: MediaQuery.of(context).size.height * .25,
                        //      width: MediaQuery.of(context).size.width * .75,
                        child: Image.network(
                      widget.informationProfile.images[index].path,
                      fit: BoxFit.fill,
                    ))),
              ),
            );
          },
        ),
      ),
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: widget.informationProfile.images,
          initialIndex: index,
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.initialIndex,
    @required this.galleryItems,
  });

  final int initialIndex;

  final List<ImagesUser> galleryItems;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;

    super.initState();
  }

  PageController pageControllerChange;

  void onPageChanged(int index) {
    print("index = " + index.toString());
    print("currentIndex = " + currentIndex.toString());
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: PhotoViewGallery.builder(
        pageController: PageController(initialPage: currentIndex),
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions.customChild(
            child: Image.network(
              widget.galleryItems[index].path,
            ),
            heroAttributes: PhotoViewHeroAttributes(tag: Uuid().v4()),
          );
        },
        itemCount: widget.galleryItems.length,

        backgroundDecoration: BoxDecoration(color: Colors.white),

        onPageChanged: onPageChanged,
        //      scrollDirection: widget.scrollDirection,
      ),
    );
  }
}
