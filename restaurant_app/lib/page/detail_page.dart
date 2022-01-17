import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 28.0,
                  left: 0.0,
                  right: 0.0,
                  child: connected
                      ? Visibility(
                          visible: true,
                          child: Container(),
                        )
                      : Container(
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              "Loss Connection",
                            ),
                          ),
                        ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChangeNotifierProvider<DetailRestaurantProvider>(
                      create: (_) => DetailRestaurantProvider(
                          detailApiService: ApiService(), id: restaurant.id),
                      child: const DetailRestaurantWidget(),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Container(),
        ),
      ),
    );
  }
}
