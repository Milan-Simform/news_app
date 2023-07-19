import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/apibase/base_model.dart';
import 'package:news_app/apibase/repository.dart';
import 'package:news_app/models/response/article/article.dart';
import 'package:news_app/modules/home_page_old/pagination_store.dart';
import 'package:news_app/utils/debouncer.dart';
import 'package:news_app/utils/extensions.dart';
import 'package:news_app/values/strings.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    onInit();
  }

  List<ReactionDisposer> disposers = [];

  final Repository repository = Repository();

  PaginationStore<Article> latestNewsPaginationStore =
      PaginationStore<Article>(pageSize: 5);

  PaginationStore<Article> categoryWiseNewsPaginationStore =
      PaginationStore<Article>(pageSize: 20);

  PaginationStore<Article> searchedNewsPaginationStore =
      PaginationStore<Article>(pageSize: 20);

  final searchController = TextEditingController();

  final debouncer = Debouncer(500.ms);

  // this index is for Catagory Menu
  @observable
  int currentIndex = 0;

  @observable
  List<String> categoryList = AppStrings.categoryList;

  // if this bool is true then show searchedNewsList else show other two lis on screen
  @computed
  bool get isSearchOn => searchController.text.trim().isNotEmpty;

  @computed
  List<Article> get latestNewsList => latestNewsPaginationStore.itemList;
  @computed
  List<Article> get categoryWiseNewsList =>
      categoryWiseNewsPaginationStore.itemList;
  @computed
  List<Article> get searchedNewsList => searchedNewsPaginationStore.itemList;

  void onInit() {
    latestNewsPaginationStore.fetchItems(fetchLatestNews);
    categoryWiseNewsPaginationStore.fetchItems(fetchCategoryWiseNews);
    disposers.add(
      reaction((_) => currentIndex, (_) {
        print('currentIndex______________');
        categoryWiseNewsPaginationStore.reset();
      }),
    );
    latestNewsPaginationStore.addListener(40, fetchLatestNews);
    categoryWiseNewsPaginationStore.addListener(40, fetchCategoryWiseNews);
    searchedNewsPaginationStore.addListener(40, fetchSearchedNews);
    searchController.addListener(() {
      fetchSearchedNews(
        searchedNewsPaginationStore.currentPage,
        searchedNewsPaginationStore.pageSize,
      );
    });
  }

  Future<BaseModel<List<Article>>> fetchLatestNews(
    int page,
    int pageSize,
  ) async {
    return repository.getLatestArticles(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<BaseModel<List<Article>>> fetchCategoryWiseNews(
    int page,
    int pageSize,
  ) async {
    return repository.getTopicWiseArticles(
      topic: categoryList[currentIndex].toLowerCase(),
      page: page,
      pageSize: pageSize,
    );
  }

  Future<BaseModel<List<Article>>> fetchSearchedNews(
    int page,
    int pageSize,
  ) async {
    final completer = Completer<BaseModel<List<Article>>>();
    debouncer.call(() {
      if (searchController.text.trim().isNotEmpty) {
        completer.complete(
          repository.getSearchedArticles(
            query: searchController.text.trim().toLowerCase(),
            page: page,
            pageSize: pageSize,
            topic: categoryList[currentIndex].toLowerCase(),
          ),
        );
      } else {
        searchedNewsPaginationStore.reset();
        completer.complete(BaseModel());
      }
    });
    return completer.future;
  }

  void dispose() {
    latestNewsPaginationStore.dispose();
    categoryWiseNewsPaginationStore.dispose();
    searchedNewsPaginationStore.dispose();
    searchController.dispose();
    for (final disposer in disposers) {
      disposer.call();
    }
  }
}
