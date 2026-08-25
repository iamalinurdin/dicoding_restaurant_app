import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/providers/home/restaurants_list_provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/providers/main/theme_provider.dart';
import 'package:restaurant_app/screens/add_review/add_review_screen.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/main/main_screen.dart';
import 'package:restaurant_app/style/theme/ui_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantsListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiService>()),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: UiTheme.lightTheme,
      darkTheme: UiTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().isLightTheme
          ? ThemeMode.light
          : ThemeMode.dark,
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainScreen(),
        '/detail': (context) => DetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
        '/add_review': (context) => AddReviewScreen(
          restaurant:
              ModalRoute.of(context)?.settings.arguments as RestaurantDetail,
        ),
      },
    );
  }
}
