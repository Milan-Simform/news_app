import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/modules/home_page/home_page.dart';

class AppRouter {
  factory AppRouter() => instance;

  AppRouter._internal();

  static final AppRouter instance = AppRouter._internal();

  final router = GoRouter(
    routes: [
      AppRoute(
        path: '/',
        builder: (s) => const HomePage(),
      ),
    ],
  );
}

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  AppRoute({
    required super.path,
    required Widget Function(GoRouterState s) builder,
    bool useFade = false,
    List<GoRoute> routes = const [],
  }) : super(
          routes: routes,
          pageBuilder: (context, state) {
            final child = Scaffold(
              body: builder(state),
            );
            if (useFade) {
              return CustomTransitionPage(
                child: child,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return MaterialPage(child: child);
          },
        );
}
