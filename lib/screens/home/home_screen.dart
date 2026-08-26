import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/home/restaurants_list_provider.dart';
import 'package:restaurant_app/screens/home/restaurant_item_list.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/ui/sliver_header_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    Future.microtask(() {
      context.read<RestaurantsListProvider>().fetchRestaurantList();
    });
    super.initState();
  }

  SliverPersistentHeader _header(BuildContext context) {
    final double sliverInitialHeight = 150;

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: sliverInitialHeight,
        maxHeight: sliverInitialHeight + 50,
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
          Consumer<RestaurantsListProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                RestaurantListLoadingState() => SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                RestaurantListLoadedState(data: var restaurants) =>
                  SliverList.builder(
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
                  ),
                RestaurantListErrorState(error: var message) =>
                  SliverFillRemaining(
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
                              message,
                              style: Theme.of(context).textTheme.titleMedium!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                _ => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('fetching restaurants data'),
                      ],
                    ),
                  ),
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
