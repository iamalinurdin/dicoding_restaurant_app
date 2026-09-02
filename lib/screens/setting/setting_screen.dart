import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/main/notification_provider.dart';
import 'package:restaurant_app/providers/main/theme_provider.dart';
import 'package:restaurant_app/widgets/sliver_header.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverHeader(maxHeight: 125, minHeight: 125, title: 'Setting'),
          SliverList.list(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: context.watch<ThemeProvider>().isDarkMode,
                      onChanged: (value) {
                        context.read<ThemeProvider>().toggleTheme(value);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'Daily Reminder',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: context
                          .watch<NotificationProvider>()
                          .dailyReminder,
                      onChanged: (value) {
                        context
                            .read<NotificationProvider>()
                            .toggleDailyReminder(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
