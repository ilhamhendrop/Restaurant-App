import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';


const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

class GetApiService {

  Future<Welcome> getRestaurant() async {
    final respone = await http.get(Uri.parse(_baseUrl + "list"));
    if(respone.statusCode == 200) {
      return Welcome.fromJson(json.decode(respone.body));
    } else {
      throw Exception('Failed to load data restaurant');
    }
  }
}

class DetailApiService {
  Future<Detail> getDetailRestaurant(String id) async {
    final respone = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if(respone.statusCode == 200) {
      return Detail.fromJson(json.decode(respone.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }
}