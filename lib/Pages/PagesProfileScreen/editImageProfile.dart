import 'dart:io';

import 'package:cv_sports/Model/usersApi.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Providers/InformationUserProvider.dart';
import 'package:cv_sports/Services/AllServices/serviceCreatePost.dart';
import 'package:cv_sports/Services/AllServices/serviceUpdateImageProfile.dart';
import 'package:cv_sports/Services/AllServices/serviceUpdatePlayer.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../ProviderAll.dart';

class editImageProfile extends StatefulWidget {
  @override
  _editImageProfileState createState() => _editImageProfileState();
}

class _editImageProfileState extends State<editImageProfile> {
  List<File> imageClub = List(6);
  final picker = ImagePicker();
  Users informationProfile;
  List<int> imageClubId = List(6);
  bool uploadData = false;

  @override
  Widget build(BuildContext context) {
    informationProfile =
        Provider.of<InformationMyProfileProvider>(context).listInformationUser;
    return Scaffold(
      backgroundColor: Color(0xffF9FAFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF9FAFF),
        centerTitle: true,
        title: Text(
          "Add image".tr(),
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: uploadData
          ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
              Text("Uploading".tr()),
              Card(
                elevation: 5,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  Provider.of<ProviderConstants>(context, listen: true)
                      .finishUpload
                      .toString() +
                      "% / " +
                      "100%",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ))
          : Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              children: [
                      Text(
                        "Add photos".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: (10 / MediaQuery.of(context).size.width) *
                            MediaQuery.of(context).size.width,
                      ),
                      Text(
                        "(Maximum 6 photos)".tr(),
                        style: TextStyle(
                          color: Color(0xff8D8D8D),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
            ),
          ),
          Container(
            width: double.infinity,
            height: .38 * MediaQuery.of(context).size.width,
            //  color: Color(0xffE3E7F1),
            padding: EdgeInsets.all(0),
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      try {
                        getImage(indexImage: index);
                      } catch (e) {
                        setState(() {
                          uploadData = false;
                        });
                        print("Error = " + e.toString());
                      }
                    },
                    child: Container(
                      height: .175 * MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(left: 8, right: 2),
                      // padding: EdgeInsets.all(5),
                      child: imageClub[index] == null
                          ? SizedBox(
                          child: Icon(
                            Icons.image,
                            color: Color(0xff68699C),
                            size: 150,
                          ))
                          : Image.file(imageClub[index]),
                    ),
                  );
                }),
          ),
          BottomApp(
            title: "Update".tr(),
            setCircular: 10,
            functionButton: () {
              setState(() {
                uploadData = true;
              });

              List newMedia = [];
              for (int i = 0; i < imageClubId.length; i++) {
                if (imageClubId[i] != null) {
                  newMedia.add(imageClubId[i]);
                }
              }
              print(imageClubId.toString() + " = List");

              ServiceUpdateImageProfile()
                  .uploadImageProfile(media: newMedia)
                  .then((value) {
                if (value.statusCode == 200) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                } else {
                  setState(() {
                          uploadData = false;
                        });
                      }
                    });
                  },
                  setWidth: .8,
                  oneColor: Color(0xff2C2B53),
                  twoColor: Color(0xff2C2B53),
                  colorTitle: Colors.white,
                ),
                GridView.builder(
                  itemCount: informationProfile.images.length,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: .70),
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0, color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: FullScreenWidget(
                                  backgroundColor: Colors.white,

                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(25),
                                      child: Container(
                                        height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .75,
                                          child: InteractiveViewer(
                                            //     boundaryMargin: EdgeInsets.all(100),
                                            minScale: 0.1,
                                            // min scale
                                            maxScale: 4.6,
                                            // max scale
                                            scaleEnabled: true,
                                            panEnabled: true,

                                            child: Image.network(
                                              informationProfile
                                                  .images[index].path,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          )


                                      ),
                                    )

                                )),
                          ),
                          height: MediaQuery.of(context).size.height * .125,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red.shade300,
                            ),
                            onPressed: () async {
                              ServiceUpdateImageProfile().DeleteImageProfile(
                                  Idmedia: informationProfile.images[index].id);
                              setState(() {
                                informationProfile.images.removeAt(index);
                              });
                            })
                      ],
                    );
                  },
                )
              ],
      ),
    );
  }

  Future<Response> uploadImagePost({
    @required File image,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UploadImagePost);

      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      Response response = await Dio().postUri(uri, data: formData,
          onSendProgress: (int sent, int total) {
            print("$sent / image  / $total");

            Provider.of<ProviderConstants>(context, listen: false)
                .getDataUpload(start: sent, end: total);
          }, options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("UploadImagePost " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("UploadImagePost  error " + e.response.data.toString());
      return e.response;
    }
  }

  Future getImage({@required int indexImage}) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      uploadData = true;
    });
    try{
      uploadImagePost(image: File(pickedFile.path)).then((v) {
        imageClubId[indexImage] = v.data["media_id"];
        setState(() {
          uploadData = false;
        });
      });
      setState(() {
        if (pickedFile != null) {
          imageClub[indexImage] = File(pickedFile.path);
          //  imageClub = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
    catch (e) {
      setState(() {
        uploadData = false;
      });
      print("Error = " + e.toString());
    }


  }
}
