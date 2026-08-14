import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/main/index_nav_provider.dart';
import 'package:restaurant_app/providers/main/theme_provider.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/main/main_screen.dart';
import 'package:restaurant_app/style/theme/ui_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
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
      },
    );
  }
}
