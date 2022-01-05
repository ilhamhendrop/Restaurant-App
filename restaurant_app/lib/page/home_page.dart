import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/welcome.dart';
import 'package:restaurant_app/page/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/data/restaurant.json'),
        builder: (context, snapshot) {
          var json = jsonDecode(snapshot.data!);
          var restaurant = Welcome.fromJson(json);
          return ListView.builder(
            itemCount: restaurant.restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurant.restaurants[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            restaurant.pictureId,
            width: 100,
          ),
      ),
      title: Text(
        restaurant.name,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          const SizedBox(height: 4.0,),
          Row(
            children: <Widget>[
              const Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              Text(restaurant.city),
            ],
          ),
          const SizedBox(height: 4.0,),
          Row(
            children: <Widget>[
              const Icon(
                Icons.star_rate,
                color: Colors.grey,
              ),
              Text(restaurant.rating.toString()),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
      },
    );
  }
}