import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/convert_data.dart';

class DetailWidget extends StatelessWidget {
  final DetailRestaurant resto;

  const DetailWidget({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isRestaurant(resto.id),
          builder: (context, snapshot) {
            var isFavorit = snapshot.data ?? false;
            return Material(
              child: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                          tag: Image.network(
                              'https://restaurant-api.dicoding.dev/images/large/${resto.pictureId}'),
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${resto.pictureId}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                resto.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              isFavorit
                                  ? IconButton(
                                      icon: const Icon(Icons.favorite),
                                      color: Colors.red,
                                      onPressed: () =>
                                          provider.removeRestaurant(resto.id),
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.favorite_border),
                                      color: Colors.red,
                                      onPressed: () => provider.addRestaurant(
                                          toConvertRestaurantDetailtoRestaurant(
                                              resto)),
                                    ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              Text(
                                resto.address + ',' + resto.city,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.star_rate,
                                color: Colors.yellow,
                              ),
                              Text(resto.rating.toString()),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: resto.categories
                                .map((category) => Text(category.name))
                                .toList(),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            resto.description,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const Text(
                            'Menu',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: resto.menus.foods
                                  .map((food) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: <Widget>[
                                                  const Icon(Icons.shop),
                                                  Text(food.name),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Drinks',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: resto.menus.drinks
                                  .map((drink) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: <Widget>[
                                                  const Icon(Icons.shop),
                                                  Text(drink.name),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Review',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SingleChildScrollView(
                              padding: const EdgeInsets.all(8),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Row(
                                    children: resto.customerReviews
                                        .map((review) => Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(review.name),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(review.review),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(review.date),
                                                  ],
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
