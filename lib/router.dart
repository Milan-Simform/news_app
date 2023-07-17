import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/modules/home_page/home_page.dart';

class AppRouter {
  factory AppRouter() => instance;
  AppRouter._internal();
  static final AppRouter instance = AppRouter._internal();
  // static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  // static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  final router = GoRouter(
    routes: [
      ShellRoute(
        builder: (_, state, child) => Scaffold(body: child),
        routes: [
          AppRoute(
            path: '/',
            routes: [
              AppRoute(
                path: 'home',
                builder: (s) => const HomePage(),
                useFade: true,
              ),
              AppRoute(
                path: 'home1',
                builder: (s) => const Center(
                  child: Text('HomePage'),
                ),
              ),
            ],
            builder: (s) => Builder(
              builder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go('/home'),
                        child: const Text('HomePage'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.go('/home1'),
                        child: const Text('HomePage1'),
                      ),
                    ],
                  ),
                );
              },
            ),
            useFade: true,
          ),
        ],
      )
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
