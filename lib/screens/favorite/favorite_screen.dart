import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/favorite/favorite_provider.dart';
import 'package:restaurant_app/screens/favorite/favorite_item_list.dart';
import 'package:restaurant_app/widgets/sliver_header.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<FavoriteProvider>().getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverHeader(
            minHeight: 150,
            maxHeight: 175,
            title: 'Favorites',
            description: 'List your favorite restaurants.',
          ),
          Consumer<FavoriteProvider>(
            builder: (context, value, child) {
              if (value.favorites == null) {
                return SliverFillRemaining(child: SizedBox());
              }

              if (value.favorites!.isEmpty) {
                return SliverFillRemaining(
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Icon(Icons.warning_rounded, size: 40),
                      Text(
                        "You don't have any favorite restaurants list",
                        textAlign: .center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                );
              }

              return SliverList.builder(
                itemCount: value.favorites!.length,
                itemBuilder: (context, index) {
                  final favorite = value.favorites![index];
                  return FavoriteItemList(
                    favorite: favorite,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: favorite.id,
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
