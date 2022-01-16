import 'package:flutter/material.dart';
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
        child: ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (_) => DetailRestaurantProvider(
              detailApiService: ApiService(), id: restaurant.id),
          child: const DetailRestaurantWidget(),
        ),
      ),
    );
  }
}
