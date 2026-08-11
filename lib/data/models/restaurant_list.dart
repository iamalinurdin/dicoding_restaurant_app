class RestaurantList {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;

  RestaurantList({
    required this.city,
    required this.description,
    required this.id,
    required this.name,
    required this.pictureId,
    required this.rating,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      city: json['city'],
      description: json['description'],
      id: json['id'],
      name: json['name'],
      pictureId: json['pictureId'],
      rating: json['rating'],
    );
  }
}
