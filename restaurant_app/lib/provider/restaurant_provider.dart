import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/search_restaurant.dart';
import 'package:restaurant_app/service/api_service.dart';

enum RestaurantState {Loading, NoData, HasData, Error}

class GetRestaurantProvider extends ChangeNotifier {
  final GetApiService getApiService;

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

class DetailRestaurantProvider extends ChangeNotifier {
  final DetailApiService detailApiService;
  final String id;

  DetailRestaurantProvider({required this.detailApiService, required this.id}){
    _fecthDetailRestaurant(id);
  }

  late Detail _detailResto;
  late RestaurantState _restaurantState;
  late String _message = '';

  String get message => _message;
  Detail get detailResto => _detailResto;
  RestaurantState get restaurantState => _restaurantState;

  Future<dynamic> _fecthDetailRestaurant(String id) async {
    try {
      _restaurantState = RestaurantState.Loading;
      notifyListeners();
      final detail = await detailApiService.getDetailRestaurant(id);
      if(detail.error){
        _restaurantState = RestaurantState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _restaurantState = RestaurantState.HasData;
        notifyListeners();
        return _detailResto = detail;
      }

    } catch(e) {
      _restaurantState = RestaurantState.Error;
      notifyListeners();
      return _message = 'Error ---> $e';
    }

  }
}

class SearchRestaurantProvider extends ChangeNotifier {
  final SearchApiService searchApiService;

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
      _restaurantState = RestaurantState.Loading;
      _query = query;
      final searchRes = await searchApiService.searchRestaurant(query);
      if(searchRes.restaurants.isEmpty){
        _restaurantState = RestaurantState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _restaurantState = RestaurantState.HasData;
        notifyListeners();
        return _searchResto = searchRes;
      }

    } catch(e) {
      _restaurantState = RestaurantState.Error;
      notifyListeners();
      return _message = 'Error ---> $e';
    }
  }
}