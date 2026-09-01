import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';

class FavoriteItemList extends StatelessWidget {
  const FavoriteItemList({
    super.key,
    required this.favorite,
    required this.onTap,
  });

  final RestaurantFavoritesList favorite;
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
                child: Image.network(favorite.image, fit: .cover),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    favorite.name,
                    style: TextStyle(fontWeight: .w600, fontSize: 18),
                  ),
                  Row(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Icon(Icons.location_pin, size: 16),
                      Text(favorite.city),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Icon(Icons.star, size: 16),
                      Text(favorite.rating.toString()),
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
