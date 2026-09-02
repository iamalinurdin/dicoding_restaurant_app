import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/home/restaurants_list_provider.dart';
import 'package:restaurant_app/screens/home/restaurant_item_list.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widgets/sliver_header.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverHeader(
            minHeight: 150,
            maxHeight: 175,
            title: 'Restaurants',
            description: 'Recommendation restaurants for you.',
          ),
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
