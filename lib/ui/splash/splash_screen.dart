import 'package:flutter/material.dart';
import 'package:flutter_gorouter/_core/settings_provider.dart';
import 'package:flutter_gorouter/router.dart';
import 'package:flutter_gorouter/ui/_core/app_colors.dart';
import 'package:flutter_gorouter/ui/_core/dimensions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/banners/banner_splash.png",
              width: width(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 128.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 32,
                  children: [
                    Image.asset("assets/logo.png", width: 192),
                    Column(
                      children: [
                        Text(
                          "Um parceiro inovador para sua",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "melhor experiência culinária!",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width(context),
                      child: ElevatedButton(
                        onPressed: () {
                          _onBoraButtonPressed(context);
                        },
                        child: Text("Bora!"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onBoraButtonPressed(BuildContext context) {
    context.read<SettingsProvider>().isUserAuthenticated = true;
    context.go(AppRouter.home);
  }
}
