import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPermission {
  static Future<void> request() async {
    final plugin = FlutterLocalNotificationsPlugin();

    final android =
        plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();
  }
}
