import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant_app/utils/notificartion_helper.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal(){
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initIsolate(){
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getRestaurant();
    await _notificationHelper.showNotification(flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

}