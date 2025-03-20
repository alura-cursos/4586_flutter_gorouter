import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gorouter/ui/_core/app_theme.dart';
import 'package:flutter_gorouter/_core/bag_provider.dart';
import 'package:flutter_gorouter/ui/_core/dimensions.dart';
import 'package:flutter_gorouter/ui/_core/widgets/appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/restaurants_data.dart';
import '../../models/dish.dart';
import '../../models/restaurant.dart';
import '../../router.dart';
import '../not_found/not_found_screen.dart';

class DishScreen extends StatefulWidget {
  final String dishId;
  final String restaurantId;
  const DishScreen({
    super.key,
    required this.dishId,
    required this.restaurantId,
  });

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  int amount = 1;

  Restaurant? restaurant;
  Dish? dish;
  bool? isNotFound;

  @override
  void initState() {
    super.initState();
    Iterable<Restaurant> query = context
        .read<RestaurantsData>()
        .listRestaurant
        .where((e) => e.id == widget.restaurantId);

    if (query.isEmpty) {
      isNotFound = true;
    } else {
      restaurant = query.first;
      Iterable<Dish> queryDish = restaurant!.listDishes.where(
        (e) => e.id == widget.dishId,
      );

      if (queryDish.isEmpty) {
        isNotFound = true;
      } else {
        dish = queryDish.first;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isNotFound != null && isNotFound!) {
      return NotFoundScreen();
    }

    if (restaurant != null && dish != null) {
      return Scaffold(
        appBar: getAppBar(
          context: context,
          title: restaurant!.name,
          onBackPressed: () => backToRestaurant(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/dishes/default.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      dish!.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "R\$${dish!.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Text(dish!.description),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      onPressed: () => _removeAmount(),
                      icon: Icon(Icons.arrow_drop_down_sharp),
                      style: AppTheme.iconButtonStylized,
                    ),
                    Text(amount.toString(), style: TextStyle(fontSize: 18)),
                    IconButton.filled(
                      onPressed: () => _addAmount(),
                      icon: Icon(Icons.arrow_drop_up_sharp),
                      style: AppTheme.iconButtonStylized,
                    ),
                  ],
                ),
                SizedBox(
                  width: width(context),
                  child: ElevatedButton(
                    onPressed: () => _addToBag(context),
                    child: Text("Adicionar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void _addAmount() {
    setState(() {
      amount++;
    });
  }

  void _removeAmount() {
    setState(() {
      amount = max(1, amount - 1);
    });
  }

  void _addToBag(BuildContext context) {
    if (dish != null) {
      List<Dish> dishesToAdd = [];
      for (int i = 0; i < amount; i++) {
        dishesToAdd.add(dish!);
      }
      context.read<BagProvider>().addAllDishes(dishesToAdd);
      print(context.read<BagProvider>().listDishesOnBag.length);
    }
  }

  backToRestaurant() {
    if (restaurant != null) {
      context.go("${AppRouter.restaurant}/${restaurant!.id}");
    }
  }
}
