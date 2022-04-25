import 'package:cv_sports/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bot_toast/bot_toast.dart';
import 'Pages/SubScreen/OnePostScreenAllPostShare.dart';
import 'Pages/home/MainScreen.dart';
import 'Pages/home/VoteScreen.dart';
import 'Pages/home/filter_Screen.dart';
import 'ProviderAll.dart';
import 'Providers/AdvertismentsProvider.dart';
import 'Providers/AllFollowProvider.dart';
import 'Providers/CategoryProvider.dart';
import 'Providers/CommentsChatProviuder.dart';
import 'Providers/CountryProvider.dart';
import 'Providers/FilterDataProvider.dart';
import 'Providers/InformationUserProvider.dart';
import 'Providers/NationalityProvider.dart';
import 'Providers/NewsProvider.dart';
import 'Providers/ProviderNofitcition.dart';
import 'Providers/ProviderShowAllPosts.dart';
import 'Providers/ProviderShowComments.dart';
import 'Providers/RolesSportProvider.dart';
import 'Providers/UserInformationProvider.dart';
import 'Providers/UsersProvider.dart';
import 'Providers/VideosHomePageProvider.dart';
import 'Providers/VoteProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
      Locale('es'),
      Locale('pt'),
      Locale('fr')
    ],
    path: "assets/langs",
    /*startLocale: Locale('ar'),*/
    saveLocale: true,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initDynamicLinks() async {
    // this is called when app comes from background

    print("Enter");
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print("deepLink " + deepLink.toString());

        print(deepLink.path);
        if (deepLink.path == "/PostShare") {
          print(deepLink.query.replaceFirst("PostId=", ""));

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OnePostScreenAllPostShare(
              postId: int.parse(deepLink.query.replaceFirst("PostId=", "")),
            ),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VoteScreen(
              isDynamic: true,
            ),
          ));
          print("Enter dy comes");
        }
      } else {
        print("deepLink == null");
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    // this is called when app is not open in background

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    print(deepLink);
    if (deepLink != null) {
      print("deepLink 2!= null");
      if (deepLink.path == "/PostShare") {
        print(deepLink.query.replaceFirst("PostId=", ""));

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OnePostScreenAllPostShare(
            postId: int.parse(deepLink.query.replaceFirst("PostId=", "")),
          ),
        ));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VoteScreen(
            isDynamic: true,
          ),
        ));
        print("Enter dy comes");
      }
    } else {
      print("deepLink 2== null");
    }
  }

  @override
  Widget build(BuildContext context) {
    initDynamicLinks();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        //or set color with: Color(0xFF0000FF)
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderConstants>(
          create: (_) => ProviderConstants(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider<RolesSportProvider>(
          create: (_) => RolesSportProvider(),
        ),
        ChangeNotifierProvider<UsersProvider>(
          create: (_) => UsersProvider(),
        ),
        ChangeNotifierProvider<UserInformationProvider>(
          create: (_) => UserInformationProvider(),
        ),
        ChangeNotifierProvider<CountryProvider>(
          create: (_) => CountryProvider(),
        ),
        ChangeNotifierProvider<AdvertismentsProvider>(
          create: (_) => AdvertismentsProvider(),
        ),
        ChangeNotifierProvider<NationalityProvider>(
          create: (_) => NationalityProvider(),
        ),
        ChangeNotifierProvider<InformationMyProfileProvider>(
          create: (_) => InformationMyProfileProvider(),
        ),
        ChangeNotifierProvider<VoteProvider>(
          create: (_) => VoteProvider(),
        ),
        ChangeNotifierProvider<VideosHomePageProvider>(
          create: (_) => VideosHomePageProvider(),
        ),
        ChangeNotifierProvider<ProviderShowComments>(
          create: (_) => ProviderShowComments(),
        ),
        ChangeNotifierProvider<ProviderShowPosts>(
          create: (_) => ProviderShowPosts(),
        ),
        ChangeNotifierProvider<NewsProvider>(
          //CommentsChatProvider
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider<CommentsChatProvider>(
          //CommentsChatProvider
          create: (_) => CommentsChatProvider(),
        ),
        ChangeNotifierProvider<FilterDataProvider>(
          //CommentsChatProvider
          create: (_) => FilterDataProvider(),
        ),
        ChangeNotifierProvider<AllFollowProvider>(
          //CommentsChatProvider
          create: (_) => AllFollowProvider(), //ProviderNofitcition
        ),
        ChangeNotifierProvider<ProviderNofitcition>(
          //CommentsChatProvider
          create: (_) => ProviderNofitcition(), //ProviderNofitcition
        ),
      ],
      /*
      child: ScreenUtilInit(
        child: MaterialApp(
          builder: BotToastInit(),
          //1. call BotToastInit
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'Cv.Sport',
          debugShowCheckedModeBanner: false,

          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
          supportedLocales: EasyLocalization.of(context).supportedLocales,
          locale: EasyLocalization.of(context).locale,

          theme: ThemeData(
            textTheme: EasyLocalization.of(context).locale ==
                    EasyLocalization.of(context).supportedLocales[1]
                ? GoogleFonts.scheherazadeTextTheme(
                    Theme.of(context).textTheme.copyWith(
                          headline6: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA9B2D2),
                          ),
                          headline4: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA9B2D2),
                          ),
                        ),
                  )
                : GoogleFonts.robotoCondensedTextTheme(
                    Theme.of(context).textTheme.copyWith(
                          headline4: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA9B2D2),
                          ),
                          headline6: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA9B2D2),
                          ),
                        ),
                  ),
            hintColor: Color(0xFFE0E3EC),
            primaryColor: Colors.white,
            //Color(0xFFFD8C44)
            accentColor: Color(0xFFFFFFFF),
            focusColor: Color(0xFF8C98A8),
            unselectedWidgetColor: Colors.red,
            backgroundColor: Color(0xFF494861),
            canvasColor: Colors.white,

            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
        ),
      ),
      */
    );
  }
}
