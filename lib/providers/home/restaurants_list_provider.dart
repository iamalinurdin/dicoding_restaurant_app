import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantsListProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantsListProvider(this._apiService);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantsList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (_) {
      _resultState = RestaurantListErrorState('failed to load restaurants');
      notifyListeners();
    }
  }
}
