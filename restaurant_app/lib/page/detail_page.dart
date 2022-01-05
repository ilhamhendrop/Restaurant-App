import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailPage({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}