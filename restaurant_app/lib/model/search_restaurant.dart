class SearchResto {
  SearchResto({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<SearchRestaurant> restaurants;

  factory SearchResto.fromJson(Map<String, dynamic> json) => SearchResto(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<SearchRestaurant>.from(json["restaurants"].map((x) => SearchRestaurant.fromJson(x))),
  );

}

class SearchRestaurant {
  SearchRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );

}