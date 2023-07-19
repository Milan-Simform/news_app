import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/modules/home_page/components/category_menu/category_menu.dart';
import 'package:news_app/modules/home_page/components/latest_article_tile.dart';
import 'package:news_app/modules/home_page/components/latest_news_scrollview.dart';
import 'package:news_app/modules/home_page/components/news_tile.dart';
import 'package:news_app/modules/home_page_old/home_store.dart';
import 'package:news_app/values/constants.dart';
import 'package:news_app/values/enumeration.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => HomeStore(),
      builder: (context, _) {
        final homeStore = context.read<HomeStore>();
        return Scaffold(
          body: NestedScrollView(
            controller:
                homeStore.categoryWiseNewsPaginationStore.scrollController,
            scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverPersistentHeader(
                pinned: true,
                delegate: AppBarWithSearchDelegate(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: kToolbarHeight,
                        ),
                        Text(
                          'Discover',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'News from all over the world.',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding,
                      ),
                      child: Text(
                        'Latest News',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 280, child: LatestNewsScrollView()),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: CategoryMenuDelegate(
                  child: NACategoryMenu(
                    categories: homeStore.categoryList,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding,
                    ),
                  ),
                ),
              ),
            ],
            body: Observer(
              builder: (context) {
                final categoryNewsStore =
                    homeStore.categoryWiseNewsPaginationStore;
                switch (categoryNewsStore.state) {
                  case StoreState.initial:
                    return const SizedBox();
                  case StoreState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case StoreState.error:
                    return Center(
                      child: Text(
                        categoryNewsStore.errorMsg,
                        textAlign: TextAlign.center,
                      ),
                    );
                  case StoreState.success:
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding,
                      ),
                      // primary: true,
                      itemCount: categoryNewsStore.itemList.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                      itemBuilder: (_, index) {
                        if (index == categoryNewsStore.itemList.length &&
                            categoryNewsStore.hasMoreData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (index == categoryNewsStore.itemList.length &&
                            !categoryNewsStore.hasMoreData) {
                          return const SizedBox();
                        }
                        return NewsTile(
                          article: categoryNewsStore.itemList[index],
                        );
                      },
                    );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class AppBarWithSearchDelegate extends SliverPersistentHeaderDelegate {
  AppBarWithSearchDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 138 + kToolbarHeight;

  @override
  double get minExtent => 138 + kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CategoryMenuDelegate extends SliverPersistentHeaderDelegate {
  CategoryMenuDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      child: child,
    );
  }

  @override
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
