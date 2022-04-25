import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class RowVideos extends StatefulWidget {
  String videoUrl;
  String videoTitle;
  bool showTitle;
  bool isFile;

  double heightVideo;
  RowVideos(
      {@required this.videoUrl,
      @required this.videoTitle,
        this.isFile = false,

      this.showTitle = true});

  @override
  _RowVideosState createState() => _RowVideosState();
}

class _RowVideosState extends State<RowVideos> {
  VideoPlayerController videoController;
  Future<void> controllerFuture;
  ChewieController chewieController;
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    print("videoUrl = "+widget.videoUrl);
    super.initState();
    VideoMake();
  }

  @override
  void dispose() {


    _betterPlayerController.dispose();
    super.dispose();
  }

  void VideoMake() async {
    videoController = VideoPlayerController.network(widget.videoUrl); //https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4
    BetterPlayerDataSource betterPlayerDataSource;
    if(widget.isFile == true){
      betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.file, widget.videoUrl);

    }else{
      betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, widget.videoUrl);

    }

    _betterPlayerController = BetterPlayerController(

        BetterPlayerConfiguration(

         autoDetectFullscreenDeviceOrientation: true,


           deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          deviceOrientationsOnFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],
fullScreenAspectRatio:16 / 9 ,
   aspectRatio:  16 / 9,
          autoDispose: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(

              // backgroundColor: Colors.red,
              controlBarColor: Colors.transparent,
              iconsColor: Colors.white,
              textColor: Colors.white,
              //   overflowMenuIconsColor: Colors.red,
              //    progressBarPlayedColor: Colors.red,
              //    progressBarHandleColor: Colors.red,
              //    progressBarBackgroundColor:Colors.red,
              //    progressBarBufferedColor: Colors.red,
              //    overflowModalColor: Colors.red,
              //    overflowModalTextColor: Colors.red,

              enablePip: false,
              showControls: true,
              enableProgressText: true,
              showControlsOnInitialize: true,
              enableOverflowMenu: false,
              enableSkips: false),
        ),

        betterPlayerDataSource: betterPlayerDataSource);
    //
    // chewieController = ChewieController(
    //   videoPlayerController: videoController,
    //
    //   autoInitialize: true,
    //   aspectRatio: 16 / 9, //4 / 3
    //   //    showControls: false,
    //   allowPlaybackSpeedChanging: false,
    //   showControlsOnInitialize: false,
    //   allowMuting: false,
    //   looping: false,
    //
    //   deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    //   deviceOrientationsOnEnterFullScreen: [
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.landscapeRight,
    //     DeviceOrientation.landscapeLeft
    //   ],
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         "خطا فى الفديو",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );

    // MediaQuery.of(context).size.width * .55,
  }

  @override
  Widget build(BuildContext context) {
    return widget.showTitle
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5),
                  //     width: MediaQuery.of(context).size.width * .6,
                  //      height: MediaQuery.of(context).size.height * .1690,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BetterPlayer(
                        controller: _betterPlayerController,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: widget.showTitle
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .52,
                              child: Text(
                                widget.videoTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      )
                    : Container(),
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                 margin: EdgeInsets.only(left: 10, right: 5),
                  //     width: MediaQuery.of(context).size.width * .6,
                  //      height: MediaQuery.of(context).size.height * .1690,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BetterPlayer(
                        controller: _betterPlayerController,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
