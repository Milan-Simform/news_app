import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/apibase/repository.dart';
import 'package:news_app/models/model.dart';
import 'package:news_app/values/enumeration.dart';

part 'latest_article_store.g.dart';

class LatestArticleStore extends _LatestArticleStore
    with _$LatestArticleStore {}

abstract class _LatestArticleStore with Store {
  _LatestArticleStore() {
    getLatestNewsArticles();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 40) {
        getLatestNewsArticles();
      }
    });
  }

  final ScrollController scrollController = ScrollController();
  final Repository repository = Repository();
  final int pageSize = 5;
  bool _isFunctionRunning = false;
  @observable
  int maxPages = 0;

  void dispose() {
    scrollController.dispose();
  }

  @observable
  StoreState state = StoreState.initial;

  @observable
  String errorMsg = '';

  ObservableList<Article> articleList = ObservableList();

  @computed
  bool get hasData => articleList.length ~/ pageSize != maxPages;

  Future<void> getLatestNewsArticles() async {
    if (!_isFunctionRunning) {
      _isFunctionRunning = true;
      final page = articleList.length ~/ pageSize + 1;
      if (page == 1) {
        state = StoreState.loading;
        errorMsg = '';
      }
      final res = await repository.getLatestArticles(
        page: page,
        pageSize: pageSize,
      );
      if (res.data != null) {
        articleList.addAll(res.data!);
        if (res.maxPages != null) {
          maxPages = res.maxPages!;
        }
        if (page == 1) {
          state = StoreState.success;
        }
      } else {
        if (res.error != null) {
          errorMsg = res.error!.getErrorMessage();
        }
        if (page == 1) {
          state = StoreState.error;
        }
      }
      _isFunctionRunning = false;
    }
  }
}
