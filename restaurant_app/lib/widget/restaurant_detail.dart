import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/detail_widget.dart';

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
          return DetailWidget(resto: resto);
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
}
