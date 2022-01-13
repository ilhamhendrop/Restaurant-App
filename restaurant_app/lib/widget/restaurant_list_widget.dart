import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetRestaurantProvider>(
      builder: (context, state, _) {
        if(state.restaurantState == RestaurantState.Loading){
          return const Center(child: CircularProgressIndicator(),);
        } else if(state.restaurantState == RestaurantState.HasData){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.welcome.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.welcome.restaurants[index];
              return CardRestaurant(restaurant: restaurant,);
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
}