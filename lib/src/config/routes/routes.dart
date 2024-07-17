import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outsera_challenge/src/features/features.dart';

abstract class AppRouter {
  static Map<String, dynamic> getRoutes(RouteSettings settings) => {
        '/': (context) => const MainPage(),
        '/movie-details': (context) => Container(),
      };

  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    final routes = AppRouter.getRoutes(settings);
    WidgetBuilder? builder = routes[settings.name];

    if (builder != null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return MaterialPageRoute(
          settings: settings,
          builder: builder,
        );
      }
    }

    return null;
  }
}
