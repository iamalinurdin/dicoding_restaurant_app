class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Map<String, String>> categories;
  final Map<String, List<Map<String, String>>> menus;
  final double rating;
  final List<Map<String, String>> customerReviews;

  RestaurantDetail({
    required this.address,
    required this.categories,
    required this.city,
    required this.customerReviews,
    required this.description,
    required this.id,
    required this.menus,
    required this.name,
    required this.pictureId,
    required this.rating,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      address: json['address'],
      categories: json['categories'],
      city: json['city'],
      customerReviews: json['customerReviews'],
      description: json['description'],
      id: json['id'],
      menus: json['menus'],
      name: json['name'],
      pictureId: json['pictureId'],
      rating: json['rating'],
    );
  }
}
