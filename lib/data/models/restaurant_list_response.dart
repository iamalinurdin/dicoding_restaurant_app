import 'package:restaurant_app/data/models/restaurant_list.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<RestaurantList> restaurants;

  RestaurantListResponse({
    required this.count,
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      count: json['count'],
      error: json['error'],
      message: json['message'],
      restaurants: json['restaurants'] != null
          ? List<RestaurantList>.from(
              json['restaurants']!.map((item) => RestaurantList.fromJson(item)),
            )
          : <RestaurantList>[],
    );
  }
}
