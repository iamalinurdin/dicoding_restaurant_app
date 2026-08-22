import 'package:restaurant_app/data/models/customer_review.dart';

class AddReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  AddReviewResponse({
    required this.customerReviews,
    required this.error,
    required this.message,
  });

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) {
    return AddReviewResponse(
      customerReviews: (json['customerReviews'] as List)
          .map((item) => CustomerReview.fromJson(item))
          .toList(),
      error: json['error'],
      message: json['message'],
    );
  }
}
