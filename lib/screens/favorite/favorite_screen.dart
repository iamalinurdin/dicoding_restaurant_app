import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/sliver_header.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomScrollView(slivers: [SliverHeader()]));
  }
}
