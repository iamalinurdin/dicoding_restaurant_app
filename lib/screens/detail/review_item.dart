import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/customer_review.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});

  final CustomerReview review;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300, minWidth: 200),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(Icons.account_circle_outlined),
                        Text(
                          review.name,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontWeight: .w500),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    review.date,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  review.review,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
