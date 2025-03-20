import 'package:flutter/material.dart';
import 'package:flutter_gorouter/router.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(AppRouter.home);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(child: Text("Página não encontrada.")),
    );
  }
}
