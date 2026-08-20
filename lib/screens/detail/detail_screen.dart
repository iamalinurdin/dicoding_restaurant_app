import 'package:flutter/material.dart';
import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/restaurant_detail_response.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<RestaurantDetailResponse> _restaurantDetailResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restaurantDetailResponse = ApiService().getRestaurantsDetail(
      widget.restaurantId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _restaurantDetailResponse,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Expanded(
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
                          'failed to get restaurants data.',
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
                );
              }

              final restaurant = snapshot.data!.restaurant;

              return SingleChildScrollView(
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
                                  Text(restaurant.rating.toString()),
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
                              Text('${restaurant.address}, ${restaurant.city}'),
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
                          child: Text(
                            'Review',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: .w500,
                                  fontFamily: 'Montserrat',
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            padding: .only(left: 12, right: 12),
                            scrollDirection: .horizontal,
                            itemCount: restaurant.customerReviews.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 12);
                            },
                            itemBuilder: (context, index) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 300,
                                  maxHeight: 150,
                                  minHeight: 150,
                                  minWidth: 200,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black87,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: .start,
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Text(
                                          restaurant
                                              .customerReviews[index]
                                              .review,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                          maxLines: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment: .spaceBetween,
                                          children: [
                                            Text(
                                              restaurant
                                                  .customerReviews[index]
                                                  .name,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall,
                                            ),
                                            Text(
                                              restaurant
                                                  .customerReviews[index]
                                                  .date,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              );
            default:
              return SizedBox();
          }
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
              return SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/images/foods.jpg', fit: BoxFit.cover),
                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Text(
                          restaurant.menus.foods[index].name,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
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
              return SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/drinks.jpg',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Text(
                          restaurant.menus.drinks[index].name,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
