import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';
import 'package:restaurant_app/providers/home/restaurants_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

// sesuaikan import model lu
import 'package:restaurant_app/data/models/restaurant_list_response.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late RestaurantsListProvider provider;

  setUp(() {
    mockApiService = MockApiService();

    provider = RestaurantsListProvider(mockApiService);
  });

  group('RestaurantsListProvider', () {
    test('initial state should be RestaurantListNoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test(
      'should return RestaurantListLoadedState when API call succeeds',
      () async {
        final mockResponse = RestaurantListResponse(
          error: false,
          message: 'success',
          count: 1,
          restaurants: [
            RestaurantList(
              id: '1',
              name: 'Test Restaurant',
              description: 'Test Description',
              pictureId: 'picture-id',
              city: 'Jakarta',
              rating: 4.5,
            ),
          ],
        );

        when(
          () => mockApiService.getRestaurantsList(),
        ).thenAnswer((_) async => mockResponse);

        await provider.fetchRestaurantList();

        expect(provider.resultState, isA<RestaurantListLoadedState>());
      },
    );

    test(
      'should return RestaurantListErrorState when API throws exception',
      () async {
        when(
          () => mockApiService.getRestaurantsList(),
        ).thenThrow(Exception('Failed to load restaurants'));

        await provider.fetchRestaurantList();

        expect(provider.resultState, isA<RestaurantListErrorState>());
      },
    );
  });
}
