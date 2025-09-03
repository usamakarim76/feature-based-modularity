// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:starterkit/core/store/user.dart';
// import 'package:starterkit/core/utils/app_logs.dart';

// class FirebaseMessagingService {
//   static final log = AppLogger(className: 'NotificationService');

//   static Future<String?> getToken() async {
//     try {
//       return await FirebaseMessaging.instance.getToken();
//     } catch (e) {
//       return null;
//     }
//   }

//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     // ✅ iOS Foreground Permission Options
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );

//     // ✅ Android Channel Setup
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'channel_id',
//       'channel_name',
//       description: 'Default channel for important notifications',
//       importance: Importance.high,
//     );

//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);

//     // ✅ Initialization Settings
//     const InitializationSettings initSettings = InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );

//     await _flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (response) {
//         log.info("🔔 Notification tapped: ${response.payload}");
//         if (response.payload != null && response.payload!.isNotEmpty) {
//           Get.toNamed(response.payload!);
//         }
//       },
//     );

//     // ✅ Ask for Notification Permission
//     final settings = await _firebaseMessaging.requestPermission();
//     log.info("🔐 Permission Status: ${settings.authorizationStatus}");

//     // ✅ Get and Save Token
//     final token = await _firebaseMessaging.getToken();
//     if (token != null) {
//       log.info("📲 FCM Token: $token");
//       await UserStore.to.saveFcmToken(token);
//       await UserStore.to.saveFcmTokenToFirestore();
//     }

//     // ✅ Listen for Token Refresh
//     _firebaseMessaging.onTokenRefresh.listen((newToken) async {
//       log.info("♻️ Token Refreshed: $newToken");
//       await UserStore.to.saveFcmToken(newToken);
//       await UserStore.to.saveFcmTokenToFirestore();
//     });

//     // ✅ Foreground Notification Listener
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log.info("📬 Foreground message: ${message.notification?.title}");
//       _showLocalNotification(message);
//     });

//     // ✅ App opened from terminated state
//     final initialMessage = await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null && initialMessage.data['route'] != null) {
//       log.info("🚀 Launched via terminated state: ${initialMessage.data}");
//       Get.toNamed(initialMessage.data['route']!);
//     }

//     // ✅ App opened from background tap
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       log.info("📲 Opened via background: ${message.data}");
//       if (message.data['route'] != null) {
//         Get.toNamed(message.data['route']!);
//       }
//     });
//   }

//   static void _showLocalNotification(RemoteMessage message) {
//     final notification = message.notification;
//     final android = message.notification?.android;

//     if (notification != null && android != null) {
//       final details = NotificationDetails(
//         android: AndroidNotificationDetails(
//           'channel_id',
//           'channel_name',
//           importance: Importance.high,
//           priority: Priority.high,
//           icon: '@mipmap/ic_launcher',
//         ),
//         iOS: const DarwinNotificationDetails(),
//       );

//       _flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         details,
//         payload: message.data['route'],
//       );
//     }
//   }

//   // ✅ Use this to show notification manually
//   static void showManualNotification({
//     String? title = "Deleted Successfully",
//     String? body = "Your item was removed.",
//     String? route,
//   }) {
//     final details = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel_id',
//         'channel_name',
//         importance: Importance.high,
//         priority: Priority.high,
//         icon: '@mipmap/ic_launcher',
//       ),
//       iOS: const DarwinNotificationDetails(),
//     );

//     _flutterLocalNotificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       details,
//       payload: route,
//     );
//   }

//   static Future<String> getDeviceToken() async {
//     final token = await _firebaseMessaging.getToken();
//     if (token != null) {
//       log.info("📱 Device FCM Token: $token");
//     }
//     return token ?? '';
//   }
// }
