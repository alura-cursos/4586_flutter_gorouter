import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '_core/settings_provider.dart';
import 'ui/checkout/checkout_screen.dart';
import 'ui/dish/dish_screen.dart';
import 'ui/home/home_screen.dart';
import 'ui/not_found/not_found_screen.dart';
import 'ui/restaurant/restaurant_screen.dart';
import 'ui/splash/splash_screen.dart';

abstract class AppRouter {
  static final String splash = "/splash";
  static final String home = "/home";
  static final String restaurant = "/restaurant";
  static final String dish = "/dish";
  static final String checkout = "/checkout";
  static final String notFound = "/404";

  static GoRouter appRouter = GoRouter(
    initialLocation: splash,
    errorPageBuilder: (context, state) {
      return MaterialPage(child: NotFoundScreen());
    },
    redirect: (context, state) {
      bool isUserAuth =
          Provider.of<SettingsProvider>(
            context,
            listen: false,
          ).isUserAuthenticated;

      if (!isUserAuth) {
        return splash;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: home, builder: (context, state) => HomeScreen()),
      GoRoute(path: notFound, builder: (context, state) => NotFoundScreen()),
      GoRoute(
        path: checkout,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: CheckoutScreen(),
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: "$restaurant/:restaurantId",
        builder: (context, state) {
          String? restaurantId = state.pathParameters["restaurantId"];
          if (restaurantId != null) {
            return RestaurantScreen(restaurantId: restaurantId);
          }
          return NotFoundScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: "$dish/:dishId",
            builder: (context, state) {
              String? restaurantId = state.pathParameters["restaurantId"];
              String? dishId = state.pathParameters["dishId"];

              if (restaurantId != null && dishId != null) {
                return DishScreen(dishId: dishId, restaurantId: restaurantId);
              }

              return NotFoundScreen();
            },
          ),
        ],
      ),
    ],
  );
}
