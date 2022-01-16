import 'package:flutter/material.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/model/respone_model.dart';

enum RestaurantState {Loading, NoData, HasData, Error}

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