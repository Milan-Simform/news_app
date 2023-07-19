import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/apibase/repository.dart';
import 'package:news_app/models/response/article/article.dart';
import 'package:news_app/values/enumeration.dart';
import 'package:news_app/values/strings.dart';

part 'category_store.g.dart';

class CategoryStore extends _CategoryStore with _$CategoryStore {}

abstract class _CategoryStore with Store {
  _CategoryStore() {
    getTopicWiseArticles(AppStrings.categoryList[currentIndex]);
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      print('__________$maxScroll _________$currentScroll _________');

      if (maxScroll - currentScroll <= 40) {
        print('____________________________');
        getTopicWiseArticles(
          AppStrings.categoryList[currentIndex],
          isPagination: true,
        );
      }
    });
  }
  @observable
  ScrollController scrollController = ScrollController();
  final Repository repository = Repository();
  final int pageSize = 20;
  bool _isFunctionRunning = false;
  @observable
  int maxPages = 0;

  @observable
  int currentIndex = 0;

  @observable
  StoreState state = StoreState.initial;

  @observable
  String errorMsg = '';

  @computed
  bool get hasData => articleList.length ~/ pageSize != maxPages;

  @observable
  ObservableList<Article> articleList = ObservableList();

  void dispose() {
    scrollController.dispose();
  }

  Future<void> getTopicWiseArticles(
    String topic, {
    bool isPagination = false,
  }) async {
    if (!_isFunctionRunning) {
      _isFunctionRunning = true;
      final page = articleList.length ~/ pageSize + 1;
      if (page == 1 || !isPagination) {
        state = StoreState.loading;
        errorMsg = '';
      }
      final res = await repository.getTopicWiseArticles(
        page: page,
        topic: topic.toLowerCase(),
      );
      if (res.data != null) {
        if (!isPagination) {
          articleList = ObservableList.of(res.data!);
        } else {
          articleList.addAll(res.data!);
        }
        if (state == StoreState.loading) {
          state = StoreState.success;
        }
      } else {
        if (res.error != null) {
          errorMsg = res.error!.getErrorMessage();
        }
        if (state == StoreState.loading) {
          state = StoreState.error;
        }
      }
      _isFunctionRunning = false;
    }
  }
}
