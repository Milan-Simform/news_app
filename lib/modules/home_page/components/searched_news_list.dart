import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/modules/home_page/components/news_tile.dart';
import 'package:news_app/modules/home_page_old/home_store.dart';
import 'package:news_app/values/constants.dart';
import 'package:news_app/values/enumeration.dart';
import 'package:provider/provider.dart';

class SearchedNewsList extends StatelessWidget {
  const SearchedNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = context.read<HomeStore>();
    return SliverToBoxAdapter(
      child: Observer(
        builder: (_) {
          final searchStore = homeStore.searchedNewsPaginationStore;
          switch (searchStore.state) {
            case StoreState.initial:
              return const SizedBox();
            case StoreState.loading:
              if (searchStore.itemList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: 12,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                controller:
                    homeStore.searchedNewsPaginationStore.scrollController,
                itemBuilder: (context, index) {
                  if (index == searchStore.itemList.length &&
                      searchStore.hasMoreData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return NewsTile(
                    article: homeStore
                        .searchedNewsPaginationStore.itemList[index],
                  );
                },
                itemCount: searchStore.itemList.length + 1,
              );
            case StoreState.error:
              if (searchStore.itemList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(searchStore.errorMsg),
                      ElevatedButton(
                        onPressed: () => searchStore
                            .fetchItems(homeStore.fetchSearchedNews),
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: 12,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                controller:
                    homeStore.searchedNewsPaginationStore.scrollController,
                itemBuilder: (context, index) {
                  if (index == searchStore.itemList.length) {
                    return Center(
                      child: IconButton(
                        onPressed: () => searchStore
                            .fetchItems(homeStore.fetchSearchedNews),
                        icon: const Icon(Icons.refresh),
                      ),
                    );
                  }
                  return NewsTile(
                    article: homeStore
                        .searchedNewsPaginationStore.itemList[index],
                  );
                },
                itemCount: searchStore.itemList.length + 1,
              );
            case StoreState.success:
              print('Max Pages: ${searchStore.maxPages}');
              print('HASMORE Pages: ${searchStore.hasMoreData}');
              if (searchStore.maxPages == 0 &&
                  searchStore.itemList.isEmpty) {
                return const Center(child: Text('No Search Found'));
              }
              return ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: 12,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                controller:
                    homeStore.searchedNewsPaginationStore.scrollController,
                itemBuilder: (context, index) {
                  if (index == searchStore.itemList.length &&
                      searchStore.hasMoreData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (index == searchStore.itemList.length &&
                      !searchStore.hasMoreData) {
                    return const Center(
                      child: Text('No More Search Found.'),
                    );
                  }
                  return NewsTile(
                    article: searchStore.itemList[index],
                  );
                },
                itemCount: searchStore.itemList.length + 1,
              );
          }
        },
      ),
    );
  }
}
