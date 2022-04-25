import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class BaseUrlApi {


  //=================== Variables ===================
  static SharedPreferences saveTokenUser;
  static SharedPreferences saveLangUser;
  static SharedPreferences saveisRunNotificatiun;

  static String lang = "ar";
  static String versionNumber = "1";
  static String tokenUser;
  static int idUser;
  //static bool isRunNotificatiun;


  //=================== getHeaderWithInToken ============
  getHeaderWithInToken() {
    return {
      HttpHeaders.authorizationHeader: "Bearer " + tokenUser,
      'Accept-Language': lang,
      'Version': '$versionNumber',
      "Accept": "application/json",
      //'Content-Type': 'application/json',
      "charset": "UTF-8"
    };
  }

  getHeaderWithInTokenChat() {
    return {
      HttpHeaders.authorizationHeader: "Bearer " + tokenUser,
      'Accept-Language': lang,
      'Version': '$versionNumber',
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "charset": "UTF-8"
    };
  }

  //=================== getHeaderWithoutToken =============

  getHeaderWithoutToken() {
    return {
      "Accept": "application/json",
      'Accept-Language': "$lang",
      'Version': '$versionNumber'
    };
  }

  //=================== Urls ===============================

  static const baseUrl = "cvsportsapp.com"; //192.168.1.2:8000 /cvsportsapp.com
  static const baseUrlSocket = "chat.cvsportsapp.com"; //"192.168.1.2"
  static const baseUrlSocketAppKey =
      "6ffbgfbgrythy"; //3278y7832hdew87fge //6ffbgfbgrythy

  static const SocketChannelComment = "posts.";
  static const SocketEventComment = "comment.added";

  static const SocketChannelChat = "private-rooms.";
  static const SocketEventChat = "message.sent";

  static const signFacebook = "/api/auth/login-with-facebook";
  static const signGoogle = "/api/auth/login-with-google";
  static const signApple = "/api/auth/login-with-apple";
  static const InformationProfileGet = "/api/user/my-profile";
  static const InformationProfileUpdate = "/api/user/update-profile";
  static const CategorySportsGet = "/api/sport";
  static const RolesSportGet = "/api/role";
  static const UsersGet = "/api/user";
  static const InformationUserGet = "/api/user/find/";
  static const CityGet = "/api/user/city";
  static const FilterData = "/api/user/filter";
  static const CountryGet = "/api/user/country";
  static const AdvertisementsGet = "/api/user/advertisements";
  static const NationalityGet = "/api/user/nationality";
  static const AddPlayerProfile = "/api/user/add-player-profile";
  static const AddClubProfile = "/api/user/add-club-profile";
  static const AddExtraProfile = "/api/user/add-extra-profile";
  static const setDeviceId = "/api/user/set-device";






  static const getQuestionVote= "/api/user/vote/active";
  static const getVideos= "/api/user/advertisements/videos";
  static const CreatePost= "/api/user/post/create";
  static const CreatePostClub= "/api/user/news/create";
  static const UploadImagePost= "/api/user/post/image/upload";
  static const UploadVideoPost= "/api/user/post/upload-video";

  static const UpdatePlayerProfile= "/api/user/update-player-profile";
  static const UpdateClubProfile = "/api/user/update-club-profile";
  static const UpdatePlayerExtra= "/api/user/update-extra-profile";

  static const UpdateImageProfile= "/api/user/upload/image/attach";
  static const AddPrize= "/api/user/add-prize";
  static const AddMedal= "/api/user/add-medal";

  static const ShowAllPosts= "/api/user/post";
  static const ShowAllNews= "/api/user/news/all";
  static const ShowAllRoom= "/api/user/chat/all-rooms";

  static const ShowAllFollowing= "/api/user/follow/my-followings";
  static const ShowAllFollowers= "/api/user/follow/my-followers";
  static const AddSocial= "/api/user/social-link/update";
  static const ContactUs= "/api/user/contact-us";
  static const AboutUs= "/api/user/setting/pages/about-us";
  static const TermsAndConditions= "/api/user/setting/pages/terms-and-conditions";
  static const AppSocialLinks= "/api/user/setting/socialLinks";

  static const AppNotifications= "/api/user/notification";
  static const AppNotificationsChange= "/api/user/set-notificationable";
  static const AppNotificationsSeen= "/api/user/notification/mark-as-read";
  static const MakeDynamiclink = "/api/user/vote/dynamic-link";
}

