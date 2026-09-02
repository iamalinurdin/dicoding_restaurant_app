import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/sliver_header_delegate.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({
    super.key,
    this.description,
    required this.maxHeight,
    required this.minHeight,
    required this.title,
  });

  final String title;
  final String? description;
  final double minHeight;
  final double maxHeight;
  final double sliverInitialHeight = 150;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
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
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  if (description != null)
                    Text(
                      description!,
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
