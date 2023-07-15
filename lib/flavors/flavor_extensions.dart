import 'package:flutter/material.dart';
import 'package:news_app/flavors/flavor_config.dart';

extension FlavorExtensions on BuildContext {
  FlavorConfig? get flavorConfig => FlavorConfig.of(this);
}
