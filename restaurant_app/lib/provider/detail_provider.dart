import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/model/respone_model.dart';

enum RestaurantState {loading, noData, hasData, error}

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService detailApiService;
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
      _restaurantState = RestaurantState.loading;
      notifyListeners();
      final detail = await detailApiService.getDetailRestaurant(id);
      if(detail.error){
        _restaurantState = RestaurantState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _restaurantState = RestaurantState.hasData;
        notifyListeners();
        return _detailResto = detail;
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