import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gold247/constant/constant.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gold247/language/languageCubit.dart';
import 'package:gold247/language/locale.dart';
import 'pages/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var deviceToken;

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Color.fromRGBO(255, 253, 228, 1).withOpacity(0.1),
    statusBarIconBrightness: Brightness.dark, // status bar color
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin fltrNotification;
  FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);

    messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print("token" + value);
      deviceToken = value;

      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        print("message recieved");
        showNotification(
            title: event.notification.title, body: event.notification.body);
        print(event.notification.body);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('Message clicked!');
      });
    });
  }

  Future notificationSelected(String payload) async {
    //  showDialog(
    //    context: context,
    //    builder: (context) => AlertDialog(
    //      content: Text("Notification : $payload"),
    //    ),
    //  );
  }
  Future showNotification({String title, String body}) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "BKS MyGold",
        channelDescription: "this is BKS MyGold",
        importance: Importance.max,
        icon: 'app_icon');
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    await fltrNotification.show(0, title, body, generalNotificationDetails,
        payload: "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en'),
                const Locale('hi'),
              ],
              //routes: PageRoutes().routes(),
              locale: locale,
              //theme: uiTheme(),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
              title: 'MyGold',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: primaryColor,
                fontFamily: 'Montserrat',
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: primaryColor,
                ),
                tabBarTheme: TabBarTheme(
                  labelColor: greyColor,
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
