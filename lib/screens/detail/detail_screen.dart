import 'package:flutter/material.dart';
import 'package:restaurant_app/data/http/api_service.dart';
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
                return Center(child: Text(snapshot.error.toString()));
              }

              final restaurant = snapshot.data!.restaurant;

              return Column(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          crossAxisAlignment: .center,
                          children: [
                            Text(
                              restaurant.name,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: .w600),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14),
                                Text(restaurant.rating.toString()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_pin, size: 16),
                            Text(restaurant.address),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          restaurant.description,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(color: Colors.black, fontWeight: .w500),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
