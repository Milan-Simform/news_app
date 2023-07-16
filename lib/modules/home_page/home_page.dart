import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/modules/home_page/components/category_menu.dart';
import 'package:news_app/modules/home_page/components/news_tile.dart';
import 'package:news_app/values/constants.dart';
import 'package:news_app/values/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            if (context.mounted) {
              context.pop();
            }
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'back',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Text(
              'Discover',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Text(
              'News from all over the world.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          // SearchBar
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.8)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),

          // Latest News. Put 5-10 articles with Horizontal ListView.
          Text('Latest News'),

          // Custom Category Menu. We can make it Sliver
          // which can stay on top after scrolling.
          const NACategoryMenu(
            categories: AppStrings.categoryList,
            padding:
                EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
          ),
          // card of Latest news
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              itemCount: 10,
              separatorBuilder: (_, __) => const SizedBox(
                height: 12,
              ),
              itemBuilder: (context, index) => const NewsTile(),
            ),
          ),
        ],
      ),
    );
  }
}
