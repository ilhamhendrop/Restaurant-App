import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import 'package:restaurant_app/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/restaurant_detail.dart';


class DetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) => DetailRestaurantProvider(detailApiService: DetailApiService(), id: widget.restaurant.id),
        child: const DetailRestaurantWidget(),
      ),
    );
  }
}