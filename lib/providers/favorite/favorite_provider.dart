import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';
import 'package:restaurant_app/services/favorite_service.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService _service;

  FavoriteProvider(this._service);

  String _message = '';
  String get message => _message;

  List<RestaurantFavoritesList>? _favorites;
  List<RestaurantFavoritesList>? get favorites => _favorites;

  Future<void> addFavorite(RestaurantFavoritesList favorite) async {
    try {
      final result = await _service.insertItem(favorite);
      final isError = result == '';

      debugPrint(result);

      if (isError) {
        _message = 'failed add new favorite restaurant';
      } else {
        _message = 'success add new favorite restaurant';
      }
    } catch (e) {
      _message = 'failed add new favorite restaurant';
    }

    notifyListeners();
  }

  Future<void> getFavorites() async {
    try {
      _favorites = await _service.getAllItems();
      _message = 'all favorites data are loaded';
    } catch (e) {
      _message = 'failed to load favorite restaurants';
    }

    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.removeItem(id);
      _message = 'your favorite is removed';
      _favorites = await _service.getAllItems();
    } catch (e) {
      _message = 'failed to remove favorite restaurant';
    }

    notifyListeners();
  }
}
