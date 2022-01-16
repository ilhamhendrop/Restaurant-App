import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widget/list_widget.dart';

class RestaurantSearch extends StatelessWidget {
  final String queries = '';

  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.restaurantState == RestaurantState.Loading) {
          return const CircularProgressIndicator(
            color: Colors.blue,
          );
        } else if (state.restaurantState == RestaurantState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.searchResto!.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.searchResto!.restaurants[index];
              return ListWidget(restaurant: restaurant);
            },
          );
        } else if (state.restaurantState == RestaurantState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.restaurantState == RestaurantState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
