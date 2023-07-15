import 'package:flutter/material.dart';
import 'package:news_app/flavors/flavor.dart';
import 'package:news_app/flavors/flavor_values.dart';

class FlavorConfig extends InheritedWidget {
  const FlavorConfig({
    required this.flavor,
    required this.values,
    required super.child,
    super.key,
  });

  final Flavor flavor;
  final FlavorValues values;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static FlavorConfig? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FlavorConfig>();
}
