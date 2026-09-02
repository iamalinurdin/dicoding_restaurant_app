import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';
import 'package:restaurant_app/services/favorite_service.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService _service;

  FavoriteProvider(this._service);

  String _message = '';
  String get message => _message;

  bool _isFavorited = false;
  bool get isFavorited => _isFavorited;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<RestaurantFavoritesList> _favorites = [];
  List<RestaurantFavoritesList> get favorites => _favorites;

  Future<void> getFavorites() async {
    try {
      _favorites = await _service.getAllItems();
      _message = 'all favorites data are loaded';
    } catch (e) {
      _message = 'failed to load favorite restaurants';
    }

    notifyListeners();
  }

  Future<void> checkFavorited(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      _isFavorited = await _service.isFavorited(id);
      _message = '';
    } catch (e) {
      _message = 'failed to check favorited';
      _isFavorited = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(RestaurantFavoritesList favorite) async {
    try {
      await _service.insertItem(favorite);

      // langsung update state
      _isFavorited = true;

      // refresh list
      _favorites = await _service.getAllItems();

      _message = 'success add new favorite restaurant';
    } catch (e) {
      _message = 'failed add new favorite restaurant';
    }

    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.removeItem(id);

      // langsung update state
      _isFavorited = false;

      // refresh list
      _favorites = await _service.getAllItems();

      _message = 'your favorite is removed';
    } catch (e) {
      _message = 'failed to remove favorite restaurant';
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(RestaurantFavoritesList restaurant) async {
    if (_isFavorited) {
      await removeFavorite(restaurant.id);
    } else {
      await addFavorite(restaurant);
    }
  }
}
