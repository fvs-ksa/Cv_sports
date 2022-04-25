import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/ProviderAll.dart';
import 'package:cv_sports/Services/AllServices/serviceCreatePost.dart';
import 'package:cv_sports/Services/baseUrlApi/baseUrlApi.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/HomeScreenWidget/RowVideos.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';

class AddPost_Image_video extends StatefulWidget {
  bool isClub;

  AddPost_Image_video({this.isClub = false});

  @override
  _AddPost_Image_videoState createState() => _AddPost_Image_videoState();
}

class _AddPost_Image_videoState extends State<AddPost_Image_video> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerClub = TextEditingController();

  int maxLengthEnd = 255;
  int maxLengthStart = 255;

  int maxLengthEndClub = 100;
  int maxLengthStartClub = 100;

  //Holds image File

  File imageClub;
  int imageClubId;

  File videoGet;
  int videoIdRespond;
  File file;

  bool closeImage = false;
  bool closeIVideo = false;

  //ImagePicker instance.
  final picker = ImagePicker();
  bool uploadData = false;

  // VideoPlayerController  runVideo;
  //================ upload Image Post ==================

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
        print("$sent / Video  / $total");

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
  //================ upload Video Post ==================

  Future<Response> uploadVideoPost({
    @required File image,
  }) async {
    try {
      Uri uri = Uri.https(BaseUrlApi.baseUrl, BaseUrlApi.UploadVideoPost);

      FormData formData = new FormData.fromMap({
        "video": await MultipartFile.fromFile(image.path),
      });

      Response response = await Dio().postUri(uri, data: formData,
          onSendProgress: (int sent, int total) {
        print("$sent / Video  / $total");
        Provider.of<ProviderConstants>(context, listen: false)
            .getDataUpload(start: sent, end: total);
      }, options: Options(headers: BaseUrlApi().getHeaderWithInToken()));

      print("uploadVideoPost " + response.data.toString());
      return response;
    } on DioError catch (e) {
      // NewUser.massageError = e.response.data.toString();
      print("uploadVideoPost  error " + e.response.data.toString());
      return e.response;
    }
  }

  //============ getImage ==============

  Future getImage() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 10);

    setState(() {
      print("Enter");
      uploadData = true;
    });
    try {
      uploadImagePost(image: File(pickedFile.path)).then((v) {
        if (v.statusCode != 200) {
          setState(() {
            uploadData = false;
          });
          BotToast.showText(
            text: "There was a problem with the upload.".tr(),
            contentColor: Colors.blue,
          );
        } else {
          print('Good Upload Image');
          imageClubId = v.data["media_id"];
          setState(() {
            closeIVideo = true;
            uploadData = false;
            if (pickedFile != null) {
              uploadData = false;
              imageClub = File(pickedFile.path);
              //  imageClub = File(pickedFile.path);
            } else {
              uploadData = false;
              print('No image selected.');
            }
          });
        }
      });
    } catch (e) {
      setState(() {
        uploadData = false;
      });
      print("Error = " + e.toString());
    }
  }
  //============ getVideo ==============

  Future getVideo() async {
    PickedFile pickedFile;

    final result = await FilePicker.getFile(type: FileType.video);

    if (result != null) {
      print("good");
      file = File(result.path);
      //  runVideo = new VideoPlayerController.file(file)..initialize();
      //   runVideo.play();
    } else {
      print("Error");
    }

    setState(() {
      print("Enter");

      uploadData = true;
    });
    //  print("File = "+ file.path);
    try {
      uploadVideoPost(image: File(file.path)).then((v) {
        print("value = " + v.statusCode.toString());

        if (v.statusCode != 200) {
          setState(() {
            uploadData = false;
            file = File(result.path);
          });
          BotToast.showText(
            text: "(Maximum one video (30 seconds))".tr(),
            contentColor: Colors.blue,
          );
        } else {
          BotToast.showText(
            text: "The video has been uploaded".tr(),
            contentColor: Colors.blue,
          );
          videoIdRespond = v.data["media_id"];
          setState(() {
            closeImage = true;
            uploadData = false;
            if (file != null) {
              uploadData = false;
              videoGet = File(file.path);
              //  imageClub = File(pickedFile.path);
            } else {
              uploadData = false;
              print('No Video  selected.');
            }
          });
        }
      });
    } catch (e) {
      setState(() {
        uploadData = false;
      });
      print("Error = " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xffF9FAFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF9FAFF),
          centerTitle: true,
          title: Text(
            "Add post".tr(),
         //   style: TextStyle(fontSize: ScreenUtil().setSp(18)),
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    widget.isClub
                        ? Column(
                            children: [
                              Container(
                                height:
                                    .115 * MediaQuery.of(context).size.height,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  maxLines: null,
                                  maxLength: maxLengthStartClub,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                    color: Colors.black,
                                  ),
                                  controller: textEditingControllerClub,
                                  onChanged: (value) {
                                    setState(() {
                                      maxLengthEndClub =
                                          maxLengthStartClub - value.length;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 18),
                                    hintText: "Write the news title".tr(),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                child: Text(
                                  maxLengthEndClub.toString(),
                                  style: TextStyle(
                                //      fontSize: ScreenUtil().setSp(18)
                                 ),
                                ),
                              ),
                              // Spacer(),
                              // SentDataButtom()
                            ],
                          )
                        : Container(),
                    NewPost(),
                    !closeImage ? addNewImage() : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    !closeIVideo ? addNewVideo() : Container(),
                    //   Spacer(),
                    BottomApp(
                      title: "send".tr(),
                      setCircular: 10,
                      functionButton: () {
                        setState(() {
                          uploadData = true;
                        });

                        print("imageClubId" + imageClubId.toString());
                        print("videoIdRespond" + videoIdRespond.toString());

                        int idMediaFinish;
                        if (imageClubId == null) {
                          idMediaFinish = videoIdRespond;
                        } else if (videoIdRespond == null) {
                          idMediaFinish = imageClubId;
                        }

                        ServiceCreatePost()
                            .postCreatePost(
                                postString: textEditingController.text.trim(),
                                media: idMediaFinish)
                            .then((value) {
                          print("Value post = " + value.data.toString());
                          if (value.statusCode == 201) {
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
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  //================== add new post =============================
  Widget NewPost() {
    return Column(
      children: [
        Container(
          height: .23 * MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: TextField(
            textAlign: TextAlign.start,
            maxLines: null,
            maxLength: maxLengthStart,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            controller: textEditingController,
            onChanged: (value) {
              setState(() {
                maxLengthEnd = maxLengthStart - value.length;
              });
            },
            decoration: InputDecoration(
              counterText: "",
              fillColor: Colors.white,
              filled: true,
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              hintText: "write here".tr(),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Text(
            maxLengthEnd.toString(),
       //     style: TextStyle(fontSize: ScreenUtil().setSp(18)),
          ),
        ),
        // Spacer(),
        // SentDataButtom()
      ],
    );
  }

  Column addNewImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: .376 * MediaQuery.of(context).size.width,
          //  color: Color(0xffE3E7F1),
          padding: EdgeInsets.all(0),
          child: InkWell(
            onTap: () => getImage(),
            child: Container(
              height: .165 * MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 8, right: 2),
              // padding: EdgeInsets.all(5),
              child: imageClub == null
                  ? SizedBox(
                      child: Icon(
                      Icons.image,
                      color: Color(0xff68699C),
                      size: 150,
                    ))
                  : Image.file(imageClub),
            ),
          ),
        ),
      ],
    );
  }

  //=============================== Widget add New Video ===========================

  Column addNewVideo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            children: [
              Text("Add a video".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                width: 10,
              ),
              Text(
                "(Maximum one video (30 seconds))".tr(),
                style: TextStyle(
                  color: Color(
                    0xff8D8D8D,
                  ),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .20, //120
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: InkWell(
            onTap: () => getVideo(),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: file == null
                    ? Image.network(
                        "https://static.thenounproject.com/png/381172-200.png",
                        fit: BoxFit.cover)
                    : RowVideos(
                        showTitle: false,
                        videoTitle: "",
                        isFile: true,
                        videoUrl: file.path,
                      )),
          ),
        ),
      ],
    );
  }
}
