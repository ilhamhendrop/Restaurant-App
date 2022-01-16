import 'package:flutter/material.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/model/respone_model.dart';

enum RestaurantState {Loading, NoData, HasData, Error}

class GetRestaurantProvider extends ChangeNotifier {
  final ApiService getApiService;

  GetRestaurantProvider({required this.getApiService}) {
    _fetchAllRestaurant();
  }

  late Welcome _welcome;
  late RestaurantState  _restaurantState;
  late String _message = '';

  String get message => _message;
  Welcome get welcome => _welcome;
  RestaurantState get restaurantState => _restaurantState;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _restaurantState = RestaurantState.Loading;
      notifyListeners();
      final restaurant = await getApiService.getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _restaurantState = RestaurantState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _restaurantState = RestaurantState.HasData;
        notifyListeners();
        return _welcome = restaurant;
      }
    } catch (e) {
      _restaurantState = RestaurantState.Error;
      notifyListeners();
      return _message = 'Error ----> $e';
    }
  }

}