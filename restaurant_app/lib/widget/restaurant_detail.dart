import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/widget/detail_widget.dart';

class DetailRestaurantWidget extends StatelessWidget {
  const DetailRestaurantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.restaurantState == RestaurantState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue,),
          );
        } else if (state.restaurantState == RestaurantState.hasData) {
          var resto = state.detailResto.restaurants;
          return DetailWidget(resto: resto);
        } else if (state.restaurantState == RestaurantState.noData) {
          return Center(child: Text(state.message));
        } else if (state.restaurantState == RestaurantState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
