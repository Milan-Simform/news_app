import 'package:flutter/material.dart';
import 'package:news_app/app.dart';
import 'package:news_app/flavors/flavor.dart';
import 'package:news_app/flavors/flavor_config.dart';
import 'package:news_app/flavors/flavor_values.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlavoredApp());
}

class FlavoredApp extends StatelessWidget {
  const FlavoredApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlavorConfig(
      flavor: Flavor.prod,
      values: FlavorValues(
        baseUrl: '',
      ),
      child: const NewsApp(),
    );
  }
}
