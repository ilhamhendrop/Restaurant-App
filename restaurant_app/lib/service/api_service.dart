import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/respone_model.dart';

class ApiService {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Welcome> getRestaurant() async {
    final respone = await http.get(Uri.parse(_baseUrl + "list"));
    if(respone.statusCode == 200) {
      return Welcome.fromJson(json.decode(respone.body));
    } else {
      throw Exception('Failed to load data restaurant');
    }
  }

  Future<Detail> getDetailRestaurant(String id) async {
    final respone = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if(respone.statusCode == 200) {
      return Detail.fromJson(json.decode(respone.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchResto> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=" + query));
    if (response.statusCode == 200) {
      return SearchResto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search');
    }
  }
}