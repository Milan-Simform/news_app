import 'package:flutter/material.dart';
import 'package:news_app/router.dart';
import 'package:news_app/utils/theme.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.instance.router,
    );
  }
}
