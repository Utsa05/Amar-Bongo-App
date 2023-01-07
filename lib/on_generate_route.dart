// ignore_for_file: unused_local_variable

import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:amar_bongo_app/presentation/pages/bottom_nav/bottom.dart';

import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> onGeneralRoute(RouteSettings settings) {
    final arg = settings.arguments;

    switch (settings.name) {
      case RouteString.initial:
        return MaterialPageRoute(builder: (context) => const BottomNavPage());
      default:
        return screenRoute(screen: const ErrorPageRoute());
    }
  }
}

class ErrorPageRoute extends StatelessWidget {
  const ErrorPageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invalid route"),
      ),
    );
  }
}

MaterialPageRoute screenRoute({required Widget screen}) {
  return MaterialPageRoute(builder: (context) => screen);
}
