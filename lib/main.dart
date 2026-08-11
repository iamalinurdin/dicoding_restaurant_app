import 'package:flutter/material.dart';
import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';
import 'package:restaurant_app/data/models/restaurant_list_response.dart';
import 'package:restaurant_app/ui/sliver_header_delegate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<RestaurantListResponse> _restaurantListResponse;

  @override
  initState() {
    _restaurantListResponse = ApiService().getRestaurantsList();
    super.initState();
  }

  SliverPersistentHeader _header(BuildContext context) {
    final double sliverHeight = 150;

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: sliverHeight,
        maxHeight: sliverHeight,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: .circular(20),
            bottomRight: .circular(20),
          ),
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 24),
              child: Column(
                mainAxisAlignment: .end,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Restaurant',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Recommendation restaurants for you.',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontWeight: .w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            _header(context),
            FutureBuilder<RestaurantListResponse>(
              future: _restaurantListResponse,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(snapshot.error.toString())),
                      );
                    }

                    final restaurants = snapshot.data!.restaurants;

                    return SliverList.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return RestaurantItemList(
                          restaurant: restaurants[index],
                        );
                      },
                    );
                  default:
                    return SliverToBoxAdapter(child: SizedBox());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantItemList extends StatelessWidget {
  const RestaurantItemList({super.key, required this.restaurant});

  final RestaurantList restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 16,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 80,
              maxHeight: 80,
              minWidth: 160,
              maxWidth: 160,
            ),
            child: Image.network('https://placehold.co/600x400'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(restaurant.name, style: TextStyle(fontWeight: .w600)),
                Row(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Icon(Icons.location_pin, size: 16),
                    Text(restaurant.city),
                  ],
                ),
                Row(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Icon(Icons.star, size: 16),
                    Text(restaurant.rating.toString()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
