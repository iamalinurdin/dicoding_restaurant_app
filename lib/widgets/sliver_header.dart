import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/sliver_header_delegate.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({super.key});
  final double sliverInitialHeight = 150;

  @override
  Widget build(BuildContext context) {
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
}
