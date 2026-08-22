import 'dart:convert';

import 'package:restaurant_app/data/models/add_review_response.dart';
import 'package:restaurant_app/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/data/models/restaurant_list_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListResponse> getRestaurantsList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurants');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantsDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load restaurants');
    }
  }

  Future<AddReviewResponse> addReview(dynamic payload) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      body: jsonEncode(payload),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AddReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to save review');
    }
  }
}
