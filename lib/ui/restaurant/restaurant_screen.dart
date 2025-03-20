import 'package:flutter/material.dart';
import 'package:flutter_gorouter/models/dish.dart';
import 'package:flutter_gorouter/models/restaurant.dart';
import 'package:flutter_gorouter/router.dart';
import 'package:flutter_gorouter/ui/_core/widgets/appbar.dart';
import 'package:flutter_gorouter/ui/restaurant/widgets/dish_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/restaurants_data.dart';
import '../not_found/not_found_screen.dart';

class RestaurantScreen extends StatefulWidget {
  final String restaurantId;
  const RestaurantScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Restaurant? restaurant;
  bool? isNotFound;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Iterable<Restaurant> query = context
          .read<RestaurantsData>()
          .listRestaurant
          .where((e) => e.id == widget.restaurantId);

      if (query.isEmpty) {
        isNotFound = true;
      } else {
        restaurant = query.first;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isNotFound != null && isNotFound!) {
      return NotFoundScreen();
    }

    if (restaurant != null) {
      return Scaffold(
        appBar: getAppBar(
          context: context,
          title: restaurant!.name,
          onBackPressed: () {
            context.go(AppRouter.home);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    "assets/${restaurant!.imagePath}",
                    width: 160,
                  ),
                ),
                Text(
                  "Mais pedidos",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Column(
                  spacing: 32,
                  children: List.generate(restaurant!.listDishes.length, (
                    index,
                  ) {
                    Dish dish = restaurant!.listDishes[index];
                    return DishWidget(dish: dish, restaurantId: restaurant!.id);
                  }),
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
