import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';

class RestaurantItemList extends StatelessWidget {
  const RestaurantItemList({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final RestaurantList restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          spacing: 16,
          children: [
            ClipRRect(
              borderRadius: .circular(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 80,
                  maxHeight: 80,
                  minWidth: 120,
                  maxWidth: 120,
                ),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                  fit: .cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontWeight: .w600,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Icon(Icons.location_pin, size: 16),
                      Text(
                        restaurant.city,
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Icon(Icons.star, size: 16),
                      Text(
                        restaurant.rating.toString(),
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
