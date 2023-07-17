import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/modules/home_page/components/category_menu.dart';
import 'package:news_app/modules/home_page/components/latest_article_tile.dart';
import 'package:news_app/modules/home_page/components/news_tile.dart';
import 'package:news_app/modules/home_page/stores/category_store.dart';
import 'package:news_app/modules/home_page/stores/latest_article_store.dart';
import 'package:news_app/values/constants.dart';
import 'package:news_app/values/enumeration.dart';
import 'package:news_app/values/strings.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => LatestArticleStore(),
        ),
        Provider(
          create: (_) => CategoryStore(),
        ),
      ],
      builder: (context, _) {
        final latestArticleStore = context.read<LatestArticleStore>();
        final categoryStore = context.read<CategoryStore>();
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 12,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(.4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16,),
                  ),
                ),
              ),

              // Latest News. Put 5-10 articles with Horizontal ListView.
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                child: Text(
                  'Latest News',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              SizedBox(
                height: 280,
                child: Observer(
                  builder: (_) {
                    switch (latestArticleStore.state) {
                      case StoreState.initial:
                        return const SizedBox();
                      case StoreState.loading:
                        return const Center(child: CircularProgressIndicator());
                      case StoreState.error:
                        return Center(child: Text(latestArticleStore.errorMsg));
                      case StoreState.success:
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => LatestArticleTile(
                            article: latestArticleStore.articleList[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 8,
                          ),
                          itemCount: latestArticleStore.articleList.length,
                        );
                    }
                  },
                ),
              ),

              // Custom Category Menu. We can make it Sliver
              // which can stay on top after scrolling.
              const SizedBox(
                height: 8,
              ),
              NACategoryMenu(
                categories: AppStrings.categoryList,
                onTap: (index) => categoryStore
                    .getTopicWiseArticles(AppStrings.categoryList[index]),
                currentIndex: categoryStore.currentIndex,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // card of Latest news
              Flexible(
                child: Observer(
                  builder: (context) {
                    switch (categoryStore.state) {
                      case StoreState.initial:
                        return const SizedBox();
                      case StoreState.loading:
                        return const Center(child: CircularProgressIndicator());
                      case StoreState.error:
                        return Text(categoryStore.errorMsg);
                      case StoreState.success:
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding,
                          ),
                          itemCount: categoryStore.articleList.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 12,
                          ),
                          itemBuilder: (_, index) => NewsTile(
                              article: categoryStore.articleList[index],),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
