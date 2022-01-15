import 'package:restaurant_app/model/restaurant.dart';

class SearchResto {
  SearchResto({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory SearchResto.fromJson(Map<String, dynamic> json) => SearchResto(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

}

