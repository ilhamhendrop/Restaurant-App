import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/page/detail_page.dart';

class ListWidget extends StatelessWidget {
  final Restaurant restaurant;

  const ListWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: Image.network('https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
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
                  color: Colors.yellow,
                ),
                Text(restaurant.rating.toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
        },
      ),
    );
  }
}