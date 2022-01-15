import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class DetailRestaurantWidget extends StatelessWidget {
  const DetailRestaurantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.restaurantState == RestaurantState.Loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue,),
          );
        } else if (state.restaurantState == RestaurantState.HasData) {
          var resto = state.detailResto.restaurants;
          return _detailRestaurant(context, resto);
        } else if (state.restaurantState == RestaurantState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.restaurantState == RestaurantState.Error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _detailRestaurant(BuildContext context, DetailRestaurant resto) {
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
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            )
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    resto.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
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
                  const SizedBox(height: 8,),
                  Row(
                    children: resto.categories.map((category) => Text(category.name)).toList(),
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
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: resto.customerReviews.map((review) => Column(
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
                          )).toList(),
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
