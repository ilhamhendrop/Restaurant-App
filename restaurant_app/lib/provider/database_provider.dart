import 'package:flutter/material.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/model/restaurant.dart';

enum RestaurantState {loading, noData, hasData, error}

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    getAllRestaurant();
  }

  late RestaurantState _state;
  RestaurantState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorit = [];
  List<Restaurant> get favorit => _favorit;

  void getAllRestaurant() async {
    _favorit = await databaseHelper.getAllRestaurant();
    if(_favorit.isNotEmpty){
      _state = RestaurantState.noData;
      _message = 'Empty Data';
    } else {
      _state = RestaurantState.hasData;
    }

    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      getAllRestaurant();
    } catch (e) {
      _state = RestaurantState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isRestaurant(String id) async {
    final favoritRestaurant = await databaseHelper.getRestaurantById(id);
    return favoritRestaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      getAllRestaurant();
    } catch (e) {
      _state = RestaurantState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

}