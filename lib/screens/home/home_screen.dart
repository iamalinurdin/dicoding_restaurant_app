import 'package:flutter/material.dart';
import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_list_response.dart';
import 'package:restaurant_app/screens/home/restaurant_item_list.dart';
import 'package:restaurant_app/ui/sliver_header_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RestaurantListResponse> _restaurantListResponse;

  @override
  initState() {
    _restaurantListResponse = ApiService().getRestaurantsList();
    super.initState();
  }

  SliverPersistentHeader _header(BuildContext context) {
    // final double sliverHeight = 150;

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: 150,
        maxHeight: 200,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: .circular(20),
            bottomRight: .circular(20),
          ),
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 24, right: 16),
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
    return Scaffold(
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
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: .center,
                            mainAxisAlignment: .center,
                            mainAxisSize: .min,
                            children: [
                              Icon(Icons.wifi_off, size: 60),
                              Text(
                                'Ooooppppssss...',
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(fontWeight: .w600),
                              ),
                              Text(
                                'failed to get restaurants data.',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  final restaurants = snapshot.data!.restaurants;

                  return SliverList.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantItemList(
                        restaurant: restaurants[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: restaurants[index].id,
                          );
                        },
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
    );
  }
}
