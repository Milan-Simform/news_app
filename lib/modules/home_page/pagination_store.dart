import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/apibase/base_model.dart';
import 'package:news_app/values/enumeration.dart';
part 'pagination_store.g.dart';

class PaginationStore<T> = _PaginationStore<T> with _$PaginationStore;

abstract class _PaginationStore<T> with Store {
  _PaginationStore({required this.pageSize});

  ObservableList<T> itemList = ObservableList();

  final scrollController = ScrollController();

  @observable
  bool isLoading = false;

  @observable
  StoreState state = StoreState.initial;

  @observable
  String errorMsg = '';

  @observable
  int currentPage = 1;

  final int pageSize;

  @observable
  int? maxPages;

  @computed
  bool get hasMoreData => maxPages != null && currentPage <= maxPages!;

  void addListener(
    double offset,
    Future<BaseModel<List<T>>> Function(int, int) fetchData,
  ) {
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;

      if (state != StoreState.error && maxScroll - currentScroll <= offset) {
        fetchItems(fetchData);
      }
    });
  }

  @action
  Future<void> fetchItems(
    Future<BaseModel<List<T>>> Function(int, int) fetchData,
  ) async {
    if (!isLoading) {
      isLoading = true;
      state = StoreState.loading;
      errorMsg = '';
      final res = await fetchData(currentPage, pageSize);
      if (res.maxPages != null) {
        maxPages = res.maxPages;
        if (maxPages == 0) {
          state = StoreState.success;
          return;
        }
      }
      _setListData(res);
      isLoading = false;
    }
  }

  void _setListData(BaseModel<List<T>> res) {
    if (res.data != null) {
      itemList.addAll(res.data!);
      currentPage++;
      state = StoreState.success;
    } else {
      errorMsg = res.error!.getErrorMessage();
      state = StoreState.error;
    }
  }

  void reset() {
    itemList.clear();
    state = StoreState.initial;
    currentPage = 1;
    maxPages = null;
    isLoading = false;
  }

  void dispose() {
    scrollController.dispose();
  }
}
