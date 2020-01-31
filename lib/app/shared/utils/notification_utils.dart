import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pocket_gtd/app/shared/models/task_model.dart';

class NotificationUtils {
  final _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  NotificationUtils() {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@drawable/ic_notification');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (i, s, s1, s2) async {});
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (s) async {});
  }

  scheduleNotification(TaskModel task) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        task.idLocal.toString(), task.title, task.details ?? '');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.schedule(
      task.idLocal,
      task.title,
      task.details ?? '',
      task.notification,
      platformChannelSpecifics,
      androidAllowWhileIdle: true
    );
  }
}
