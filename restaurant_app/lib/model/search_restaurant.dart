class Search {
  Search({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<SearchRestaurant> restaurants;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
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

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) => SearchRestaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );
}