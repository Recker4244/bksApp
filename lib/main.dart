import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gold247/constant/constant.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gold247/language/languageCubit.dart';
import 'package:gold247/language/locale.dart';
import 'package:gold247/push_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';

var deviceToken;

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  PushNotification _notificationInfo;
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

  void registerNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
        });

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo.title),
            leading: NotificationBadge(),
            subtitle: Text(_notificationInfo.body),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        // _totalNotifications++;
      });
    }
  }

  Future showNotification({String title, String body}) async {
    var androidDetails = new AndroidNotificationDetails("Channel ID", "MyGold",
        channelDescription: "MYGOLD",
        importance: Importance.max,
        icon: 'app_icon');
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    await fltrNotification.show(0, title, body, generalNotificationDetails,
        payload: "");
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
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

class NotificationBadge extends StatelessWidget {
  // final int totalNotifications;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Image.asset("assets/Logo.png"),
    );
  }
}
