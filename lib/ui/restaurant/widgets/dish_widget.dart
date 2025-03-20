import 'package:flutter/material.dart';
import 'package:flutter_gorouter/ui/_core/app_colors.dart';
import 'package:go_router/go_router.dart';

import '../../../models/dish.dart';
import '../../../router.dart';

class DishWidget extends StatelessWidget {
  final Dish dish;
  final String restaurantId;
  const DishWidget({super.key, required this.dish, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onDishPressed(context),
      child: Column(
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
          Container(
            height: 160,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundLightColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  dish.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text("R\$${dish.price.toStringAsFixed(2)}"),
                SizedBox(height: 16),
                Text(
                  "${dish.description.split(" ").sublist(0, 18).join(" ")}...",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onDishPressed(BuildContext context) {
    context.go(
      "${AppRouter.restaurant}/$restaurantId${AppRouter.dish}/${dish.id}",
    );
  }
}
