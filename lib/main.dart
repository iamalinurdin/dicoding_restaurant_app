import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/sliver_header_delegate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
            SliverList.builder(
              itemBuilder: (context, index) {
                return RestaurantItemList();
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantItemList extends StatelessWidget {
  const RestaurantItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
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
          Column(
            crossAxisAlignment: .end,
            children: [
              Text('Restaurant', style: TextStyle(fontWeight: .w600)),
              Row(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  Icon(Icons.location_pin, size: 16),
                  Text('location'),
                ],
              ),
              Row(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [Icon(Icons.star, size: 16), Text('4.5')],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
