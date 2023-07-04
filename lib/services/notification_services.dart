import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_settings/app_settings.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/user/notification/notificationscreen.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    await Future.delayed(const Duration(milliseconds: 2000), () async {
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
        print('User granted permission');
      } else {
        AppSettings.openNotificationSettings();
        print('User declined or has not accepted permission');
      }
    });
  }

  Future<String?> getDeviceToken() async {
    String? deviceToken = await firebaseMessaging.getToken();
    return deviceToken;
  }

  void initNotification(
      BuildContext buildContext, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/icon.png');

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(buildContext, message);
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
              flutterNotificationPlugin.show(
                  1,
                  message.notification!.title.toString(),
                  message.notification!.body.toString(),
                  notificationDetails)
            });
  }

  void firebaseNotificationInit(BuildContext buildContext) {
    FirebaseMessaging.onMessage.listen((message) {
      initNotification(buildContext, message);
      showNotifications(message);
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

  Future<String?> setUpInteractMessage(BuildContext buildContext) async {
    //when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(buildContext, initialMessage);
    }

    //when app is background

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(buildContext, message);
    });
  }
}
