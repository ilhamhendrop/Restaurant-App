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
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(searchApiService: SearchApiService()),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if(state.restaurantState == RestaurantState.Loading){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LinearProgressIndicator(
                    minHeight: 5,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loading....'),
                ],
              ),
            );
          } else if(state.restaurantState == RestaurantState.HasData){
            state.feacthSearchRestaurant(queries);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.searchResto.restaurants.length,
              itemBuilder: (context, index){
                var restaurant = state.searchResto.restaurants[index];
                return _searchRest(context, restaurant);
              },
            );
          } else if(state.restaurantState == RestaurantState.NoData){
            state.feacthSearchRestaurant(queries);
            return Center(child: Text(state.message),);
          } else if(state.restaurantState == RestaurantState.Error){
            return Center(child: Text(state.message),);
          } else {
            return const Center(child: Text(''),);
          }
        },
      ),
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
