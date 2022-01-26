import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurant_app/model/respone_model.dart';

class TestingApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';

  final Client client;
  TestingApiService(this.client);

  Future<Welcome> getRestaurant() async {
    final respone = await client.get(Uri.parse(baseUrl + list));
    if(respone.statusCode == 200) {
      return Welcome.fromJson(json.decode(respone.body));
    } else {
      throw Exception('Failed to load data restaurant');
    }
  }

  Future<Detail> getDetailRestaurant(String id) async {
    final respone = await client.get(Uri.parse(baseUrl + "detail/" + id));
    if(respone.statusCode == 200) {
      return Detail.fromJson(json.decode(respone.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchResto> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse(baseUrl + "search?q=" + query));
    if (response.statusCode == 200) {
      return SearchResto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search');
    }
  }
}