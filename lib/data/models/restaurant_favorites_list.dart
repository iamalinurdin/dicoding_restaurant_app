class RestaurantFavoritesList {
  final String id;
  final String name;
  final String city;
  final String image;
  final double rating;

  RestaurantFavoritesList({
    required this.city,
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
  });

  factory RestaurantFavoritesList.fromJson(Map<String, dynamic> json) {
    return RestaurantFavoritesList(
      city: json['city'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'city': city,
      'rating': rating,
    };
  }
}
