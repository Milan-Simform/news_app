import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/modules/home_page_old/components/category_menu/category_menu.dart';
import 'package:news_app/modules/home_page_old/components/latest_article_tile.dart';
import 'package:news_app/modules/home_page_old/components/news_tile.dart';
import 'package:news_app/modules/home_page_old/home_store.dart';
import 'package:news_app/modules/home_page_old/stores/category_store.dart';
import 'package:news_app/modules/home_page_old/stores/latest_article_store.dart';
import 'package:news_app/values/constants.dart';
import 'package:news_app/values/enumeration.dart';
import 'package:news_app/values/strings.dart';
import 'package:provider/provider.dart';

class HomePageFinal extends StatelessWidget {
  const HomePageFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => HomeStore(),
      dispose: (_, store) => store.dispose(),
      builder: (context, _) {
        final homeStore = context.read<HomeStore>();
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
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
                      textInputAction: TextInputAction.search,
                      controller: homeStore.searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.clear),
                        ),
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
                        final latestNewsStore =
                            homeStore.latestNewsPaginationStore;
                        switch (latestNewsStore.state) {
                          case StoreState.initial:
                            return const SizedBox();
                          case StoreState.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case StoreState.error:
                            if (latestNewsStore.currentPage == 1) {
                              return Center(
                                child: Text(
                                  latestNewsStore.errorMsg,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  //Class

                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Retry')),
                                ],
                              );
                            }
                          case StoreState.success:
                            return ListView.separated(
                              controller: latestNewsStore.scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.defaultPadding,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index == homeStore.latestNewsList.length &&
                                    latestNewsStore.hasMoreData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (index == homeStore.latestNewsList.length &&
                                    !latestNewsStore.hasMoreData) {
                                  return const Text('No more Data found');
                                }
                                return LatestArticleTile(
                                  article: homeStore.latestNewsList[index],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 8,
                              ),
                              itemCount:
                                  latestNewsStore.state == StoreState.loading
                                      ? homeStore.latestNewsList.length + 1
                                      : homeStore.latestNewsList.length,
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
                    currentIndex: homeStore.currentIndex,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding,
                    ),
                    onTap: (index) => homeStore.currentIndex = index,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // card of Latest news
                  Flexible(
                    child: Observer(
                      builder: (context) {
                        final categoryStore =
                            homeStore.categoryWiseNewsPaginationStore;
                        switch (categoryStore.state) {
                          case StoreState.initial:
                            return const SizedBox();
                          case StoreState.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case StoreState.error:
                            return Center(
                              child: Text(
                                categoryStore.errorMsg,
                                textAlign: TextAlign.center,
                              ),
                            );
                          case StoreState.success:
                            return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.defaultPadding,
                              ),
                              itemCount:
                                  homeStore.categoryWiseNewsList.length + 1,
                              controller: categoryStore.scrollController,
                              separatorBuilder: (_, __) => const SizedBox(
                                height: 12,
                              ),
                              itemBuilder: (_, index) {
                                if (index ==
                                        homeStore.categoryWiseNewsList.length &&
                                    categoryStore.hasMoreData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (index ==
                                        homeStore.categoryWiseNewsList.length &&
                                    !categoryStore.hasMoreData) {
                                  return const SizedBox();
                                }
                                return NewsTile(
                                  article:
                                      homeStore.categoryWiseNewsList[index],
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                  // ColoredBox(
                  //     color: Colors.red,
                  //     child: Center(child: Text('No Connection'))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
