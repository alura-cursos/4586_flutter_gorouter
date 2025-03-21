import 'package:flutter/material.dart';
import 'package:flutter_gorouter/data/restaurants_data.dart';
import 'package:flutter_gorouter/router.dart';
import 'package:flutter_gorouter/ui/_core/app_theme.dart';
import 'package:flutter_gorouter/_core/bag_provider.dart';
import 'package:provider/provider.dart';

import '_core/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RestaurantsData restaurantsData = RestaurantsData();
  await restaurantsData.getRestaurants();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => restaurantsData),
        ChangeNotifierProvider(create: (context) => BagProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      routerConfig: AppRouter.appRouter,
    );
  }
}
