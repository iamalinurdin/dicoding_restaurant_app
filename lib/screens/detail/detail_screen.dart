import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screens/detail/menu_item_list.dart';
import 'package:restaurant_app/screens/detail/review_item.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
        widget.restaurantId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        // future: _restaurantDetailResponse,
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailErrorState(error: var message) => Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    Icon(Icons.wifi_off, size: 60),
                    Text(
                      'Ooooppppssss...',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontWeight: .w600),
                    ),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('back to home'),
                    ),
                  ],
                ),
              ),
            ),
            RestaurantDetailLoadedState(data: var restaurant) =>
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: .only(
                            bottomLeft: .circular(20),
                            bottomRight: .circular(20),
                          ),
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 20,

                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Padding(
                          padding: .only(left: 12, right: 12, top: 20),
                          child: Row(
                            mainAxisAlignment: .spaceBetween,
                            crossAxisAlignment: .center,
                            children: [
                              Text(
                                restaurant.name,
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      fontWeight: .w600,
                                      fontFamily: 'Montserrat',
                                      fontSize: 30,
                                    ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 14),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Icon(Icons.location_pin, size: 16),
                              Text(
                                '${restaurant.address}, ${restaurant.city}',
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      fontWeight: .w500,
                                      fontFamily: 'Montserrat',
                                    ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                restaurant.description,
                                style: Theme.of(context).textTheme.labelMedium!
                                    .copyWith(
                                      fontWeight: .w400,
                                      fontFamily: 'Roboto',
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        MenusListView(restaurant: restaurant),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                'Review',
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      fontWeight: .w500,
                                      fontFamily: 'Montserrat',
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 150,
                            maxHeight: 160,
                          ),
                          child: ListView.separated(
                            padding: .only(left: 12, right: 12),
                            scrollDirection: .horizontal,
                            itemCount: restaurant.customerReviews.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 12);
                            },
                            itemBuilder: (context, index) {
                              final review = restaurant.customerReviews[index];

                              return ReviewItem(review: review);
                            },
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/add_review',
                                arguments: restaurant,
                              );
                            },
                            child: Text('Add Review'),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}

class MenusListView extends StatelessWidget {
  const MenusListView({super.key, required this.restaurant});

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Foods',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: .w500,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: .only(left: 12, right: 12),
            itemCount: restaurant.menus.foods.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },

            itemBuilder: (context, index) {
              final menu = restaurant.menus.foods[index];

              return MenuItemList(
                menuItem: menu,
                backgroundImage: 'assets/images/foods.jpg',
              );
            },
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Drinks',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: .w500,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: .only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: restaurant.menus.drinks.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              final menu = restaurant.menus.drinks[index];
              return MenuItemList(
                menuItem: menu,
                backgroundImage: 'assets/images/drinks.jpg',
              );
            },
          ),
        ),
      ],
    );
  }
}
