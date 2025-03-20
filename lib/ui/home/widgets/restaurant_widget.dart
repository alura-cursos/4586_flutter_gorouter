import 'package:flutter/material.dart';
import 'package:flutter_gorouter/models/restaurant.dart';
import 'package:flutter_gorouter/router.dart';
import 'package:go_router/go_router.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onRestaurantPressed(context),
      child: Row(
        spacing: 16,
        children: [
          Image.asset("assets/${restaurant.imagePath}", width: 96),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(restaurant.stars.floor(), (index) {
                  return Image.asset("assets/others/star.png", width: 16);
                }),
              ),
              Text("${restaurant.distance}km"),
            ],
          ),
        ],
      ),
    );
  }

  _onRestaurantPressed(BuildContext context) {
    // context.push(AppRouter.restaurant, extra: restaurant);
    context.go("${AppRouter.restaurant}/${restaurant.id}");
  }
}
