import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';
import 'package:restaurant_app/providers/favorite/favorite_provider.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.restaurant});

  final RestaurantDetail restaurant;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteProvider>().checkFavorited(widget.restaurant.id);
    });
  }

  Future<void> _toggleFavorite() async {
    final provider = context.read<FavoriteProvider>();

    final favorite = RestaurantFavoritesList(
      id: widget.restaurant.id,
      name: widget.restaurant.name,
      city: widget.restaurant.city,
      rating: widget.restaurant.rating,
      image:
          'https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId}',
    );

    if (provider.isFavorited) {
      await provider.removeFavorite(widget.restaurant.id);
    } else {
      await provider.addFavorite(favorite);
    }

    if (!mounted) return;

    final message = provider.isFavorited
        ? 'Favorite restaurant has been added'
        : 'Favorite restaurant has been removed';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final isFavorited = context.select<FavoriteProvider, bool>(
      (provider) => provider.isFavorited,
    );

    return IconButton.outlined(
      onPressed: _toggleFavorite,
      icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_outline),
      iconSize: 20,
      padding: const EdgeInsets.all(8),
    );
  }
}
