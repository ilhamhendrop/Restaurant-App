import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/notificartion_helper.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting';

  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: ListTile(
          title: const Text('Scheduling Restaurant'),
          trailing: Consumer<SchedulingProvider>(
            builder: (context, scheduling, _){
              return Switch.adaptive(
                value: scheduling.isScheduled,
                onChanged: (value) async {
                  scheduling.scheduledRestaurant(value);
                },
              );
            }
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configurareSelectNotificationSubjec(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}