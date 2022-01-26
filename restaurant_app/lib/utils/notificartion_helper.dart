import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:rxdart/subjects.dart';
import 'package:restaurant_app/model/respone_model.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final randomNumber = Random().nextInt(20);

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initSettingAndroid = const AndroidInitializationSettings('app_icon');
    var initSettings = InitializationSettings(android: initSettingAndroid);

    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Welcome restaurants) async {
    var _chId = "1";
    var _chName = "channel_01";
    var _chDescription = "Restaurant channel";

    var androidPlatformChannelSpacifics = AndroidNotificationDetails(
        _chId, _chName, _chDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpesifics = NotificationDetails(
      android: androidPlatformChannelSpacifics,
    );

    var titleNotification = "<b>Restaurant</b>";
    var titleRestaurant = restaurants.restaurants[randomNumber].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformChannelSpesifics,
      payload: json.encode({"number": randomNumber, "data": restaurants.toJson()}),
    );
  }

  void configurareSelectNotificationSubjec(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = Welcome.fromJson(json.decode(payload)["data"]);
      var restaurant = data.restaurants[json.decode(payload)["number"]].id;
      Navigation.intentWithData(route, restaurant);
    });
  }
}
