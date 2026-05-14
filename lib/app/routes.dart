import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/map/screens/map_screen.dart';
import '../features/mechanics/screens/mechanic_profile_screen.dart';
import '../features/mechanics/screens/nearby_mechanics_screen.dart';
import '../features/request/screens/request_mechanic_screen.dart';

/// go_router configuration for the FIXA prototype.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/setup-cowork',
        // Alias kept so the brief's `/setup-cowork` route resolves to login.
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/map',
        builder: (BuildContext context, GoRouterState state) =>
            const MapScreen(),
      ),
      GoRoute(
        path: '/mechanics',
        builder: (BuildContext context, GoRouterState state) {
          final String? filter = state.uri.queryParameters['filter'];
          return NearbyMechanicsScreen(initialFilter: filter);
        },
      ),
      GoRoute(
        path: '/mechanic/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? 'm1';
          return MechanicProfileScreen(mechanicId: id);
        },
      ),
      GoRoute(
        path: '/request/:mechanicId',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['mechanicId'] ?? 'm1';
          return RequestMechanicScreen(mechanicId: id);
        },
      ),
    ],
  );
}
