import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';

class Welcome {
    Welcome({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<Restaurant> restaurants;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

}

class Detail {
  Detail({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  final bool error;
  final String message;
  final DetailRestaurant restaurants;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    error: json["error"],
    message: json["message"],
    restaurants: DetailRestaurant.fromJson(json["restaurant"]),
  );
}

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