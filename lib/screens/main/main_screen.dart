import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/setting/setting_screen.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (value) =>
            context.read<IndexNavProvider>().setIndexBottomNavBar = value,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            tooltip: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
            tooltip: 'Setting',
          ),
        ],
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => HomeScreen(),
            1 => FavoriteScreen(),
            _ => SettingScreen(),
          };
        },
      ),
    );
  }
}
