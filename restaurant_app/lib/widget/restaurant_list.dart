import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/widget/list_widget.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetRestaurantProvider>(
      builder: (context, state, _) {
        if(state.restaurantState == RestaurantState.loading){
          return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
        } else if(state.restaurantState == RestaurantState.hasData){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.welcome.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.welcome.restaurants[index];
              return ListWidget(restaurant: restaurant,);
            },
          );
        } else if(state.restaurantState == RestaurantState.noData){
          return Center(child: Text(state.message),);
        } else if(state.restaurantState == RestaurantState.error){
          return Center(child: Text(state.message),);
        } else {
          return const Center(child: Text(''),);
        }
      },
    );
  }
}