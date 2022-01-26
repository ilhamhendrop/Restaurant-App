import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';

  const SettingPage({Key? key}) : super(key: key);

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
}