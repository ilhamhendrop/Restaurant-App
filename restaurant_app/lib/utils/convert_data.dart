import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';

Restaurant toConvertRestaurantDetailtoRestaurant(DetailRestaurant detailRestaurant) {
  return Restaurant(
    id: detailRestaurant.id,
    name: detailRestaurant.name,
    description: detailRestaurant.description,
    pictureId: detailRestaurant.pictureId,
    city: detailRestaurant.city,
    rating: detailRestaurant.rating,
  );
}