import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';
import 'package:restaurant_app/providers/favorite/favorite_provider.dart';
import 'package:restaurant_app/services/favorite_service.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.restaurant});

  final RestaurantDetail restaurant;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavoriteService _favoriteService = FavoriteService();

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final result = await _favoriteService.isFavorited(widget.restaurant.id);

    if (!mounted) return;

    setState(() {
      _isFavorite = result;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      context.read<FavoriteProvider>().removeFavorite(widget.restaurant.id);
    } else {
      final favorite = RestaurantFavoritesList(
        city: widget.restaurant.city,
        id: widget.restaurant.id,
        image:
            "https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId}",
        name: widget.restaurant.name,
        rating: widget.restaurant.rating,
      );
      context.read<FavoriteProvider>().addFavorite(favorite);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });

    final message = _isFavorite
        ? 'favorite restaurant has been added'
        : 'favorite restaurant has been removed';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      // onPressed: () {
      // final favorite = RestaurantFavoritesList(
      //   city: widget.restaurant.city,
      //   id: widget.restaurant.id,
      //   image:
      //       "https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId}",
      //   name: widget.restaurant.name,
      //   rating: widget.restaurant.rating,
      // );
      // context.read<FavoriteProvider>().addFavorite(favorite);
      // _favoriteService();

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(context.read<FavoriteProvider>().message)),
      // );
      // },
      onPressed: _toggleFavorite,
      icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_outline),
      iconSize: 20,
      padding: .all(8),
    );
  }
}
