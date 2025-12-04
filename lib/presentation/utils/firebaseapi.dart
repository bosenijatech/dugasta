// import 'dart:convert';

// import 'package:dugasta/main.dart';
// import 'package:dugasta/presentation/module/notificationpage/notificationpage.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> hangleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Title: ${message.notification?.body}');
//   print('payload ${message.data}');
// }

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _androidChannel = AndroidNotificationChannel(
//       'high_importance_channel', 'High Importance Notifications',
//       description: 'This Channel is used for important notification',
//       importance: Importance.defaultImportance);

//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();
//     print('TOKEN : $fcmToken');
//     initPushNotifications();
//     initLocalNotifications();
//     //FirebaseMessaging.onBackgroundMessage(hangleBackgroundMessage);
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;

//     navigatoryKey.currentState
//         ?.pushNamed(Notificationpage.route, arguments: message);
//   }

//   Future initLocalNotifications() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/launcher_icon');
//     const settings = InitializationSettings(android: android, iOS: iOS);

//     await _localNotifications.initialize(settings,
//         onSelectNotification: (payload) {
//       if (payload != null) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload!));
//         handleMessage(message);
//       }
//     });

//     Future onSelectNotification(String payload) async {
//       if (payload.toString() != "null") {
//         debugPrint('notification payload: $payload');
//       }
//     }

//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();

//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);

//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(hangleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;

//       _localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//               android: AndroidNotificationDetails(
//                   _androidChannel.id, _androidChannel.name,
//                   channelDescription: _androidChannel.description,
//                   icon: '@drawable/launcher_icon')),
//           payload: jsonEncode(message.toMap()));
//     });
//   }
// }
