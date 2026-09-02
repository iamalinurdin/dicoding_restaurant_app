import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';
import 'package:restaurant_app/providers/favorite/favorite_provider.dart';

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
      child: Dismissible(
        direction: .endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),
        key: Key(favorite.id),
        onDismissed: (direction) {
          final favoriteProvider = context.read<FavoriteProvider>();
          favoriteProvider.removeFavorite(favorite.id);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('favorite restaurant has been removed')),
          );
        },
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
      ),
    );
  }
}
