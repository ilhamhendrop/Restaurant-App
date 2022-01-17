import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/model/respone_model.dart';

enum RestaurantState {loading, noData, hasData, error}

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService searchApiService;

  SearchRestaurantProvider({required this.searchApiService}){
    feacthSearchRestaurant(query);
  }

  SearchResto? _searchResto;
  RestaurantState? _restaurantState;
  String _message = '';
  String _query = '';

  String get message => _message;
  SearchResto? get searchResto => _searchResto;
  String get query => _query;
  RestaurantState? get restaurantState => _restaurantState;

  Future<dynamic> feacthSearchRestaurant(String query) async {
    try {
      if(query.isNotEmpty){
        _restaurantState = RestaurantState.loading;
        _query = query;
        final searchRes = await searchApiService.searchRestaurant(query);
        if(searchRes.restaurants.isEmpty){
          _restaurantState = RestaurantState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _restaurantState = RestaurantState.hasData;
          notifyListeners();
          return _searchResto = searchRes;
        }
      }
    } on SocketException catch (e){
      _restaurantState = RestaurantState.error;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    } catch (e) {
      _restaurantState = RestaurantState.error;
      notifyListeners();
      return _message = 'Sorry, something is wrong...';
    }
  }
}