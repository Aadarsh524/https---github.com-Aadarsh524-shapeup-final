import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_settings/app_settings.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/user/notification/notificationscreen.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void initLocalNotification(
      BuildContext buildContext, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/icon.png');

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(buildContext, message);
    });
  }

  void firebaseInit(BuildContext buildContext) {
    FirebaseMessaging.onMessage.listen((message) {
      print("FCM Message Received: ${message.notification?.title.toString()}");
      print("FCM Message Received: ${message.notification?.body.toString()}");

      if (Platform.isAndroid) {
        initLocalNotification(buildContext, message);
        showNotifications(message);
      }
    });
  }

  Future<void> showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'high_importance_notifications',
        importance: Importance.high);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: "Channel Description",
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(
        Duration.zero,
        () => {
              flutterLocalNotificationPlugin.show(
                  1,
                  message.notification!.title.toString(),
                  message.notification!.body.toString(),
                  notificationDetails)
            });
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings notificationSetting =
        await firebaseMessaging.requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true,
            sound: true);
    if (notificationSetting.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print("User granted permission");
    } else {
      AppSettings.openNotificationSettings();
      print("User denied permission");
    }
  }

  Future<String?> getDeviceToken() async {
    String? deviceToken = await firebaseMessaging.getToken();
    return deviceToken;
  }

  void isTokenRefresh() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<String?> setInteractMessage(BuildContext buildContext) async {
    //when app is terminated
    Future<RemoteMessage?> initialMessage =
        FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(buildContext, initialMessage as RemoteMessage);
    }

    //when app is backgrounf

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(buildContext, message);
    });
  }

  void handleMessage(BuildContext buildContext, RemoteMessage message) {
    if (message.data['type'] == 'message') {
      Navigator.pushReplacement(
          buildContext,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 300),
              child: NotificationScreen(id: (message.data['id'].toString()))));
    }
  }
}
