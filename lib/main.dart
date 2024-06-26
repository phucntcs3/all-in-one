import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  // HIVE Local Storage
  await setupHive();

  // FIREBASE
  await setupFirebase();

  // NOTIFICATION
  await setupNotification();

  runApp(const App());
}

Future<void> setupHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> setupNotification() async {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    // 'resource://drawable/res_app_icon',
    null,
    [
      NotificationChannel(
        // channelGroupKey: 'aio_channel_group',
        channelKey: 'aio_channel',
        channelName: 'AIO notifications',
        channelDescription: 'Notification channel for reminder feature',
        defaultColor: Colors.red,
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}
