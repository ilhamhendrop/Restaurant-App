import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/search_restaurant.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/service/api_service.dart';

class RestaurantSearch extends StatelessWidget {
  String queries = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if(state.restaurantState == RestaurantState.Loading){
          return const CircularProgressIndicator(color: Colors.blue,);
        } else if(state.restaurantState == RestaurantState.HasData){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.searchResto?.restaurants.length,
            itemBuilder: (context, index){
              var restaurant = state.searchResto?.restaurants[index];
              return _searchRest(context, restaurant!);
            },
          );
        } else if(state.restaurantState == RestaurantState.NoData){
          return Center(child: Text(state.message),);
        } else if(state.restaurantState == RestaurantState.Error){
          return Center(child: Text(state.message),);
        } else {
          return const Center(child: Text(''),);
        }
      },
    );
  }

  Widget _searchRest(BuildContext context, SearchRestaurant restaurant) {
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
