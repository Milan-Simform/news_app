import 'package:flutter/cupertino.dart';
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

  int? _maxPages;

  @computed
  bool get hasMoreData => _maxPages != null && currentPage < _maxPages!;

  void addListener(
    double offset,
    Future<BaseModel<List<T>>> Function(int, int) fetchData,
  ) {
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= offset) {
        fetchItems(fetchData);
      }
    });
  }

  Future<void> fetchItems(
    Future<BaseModel<List<T>>> Function(int, int) fetchData,
  ) async {

    print('fetch is running.......................');
    if (!isLoading) {
      if (currentPage == 1) {
        state = StoreState.loading;
      }
      isLoading = true;
      final res = await fetchData(currentPage, pageSize);
      if (res.data != null) {
        itemList.addAll(res.data!);
        currentPage++;
        _maxPages = res.maxPages;
        if (state == StoreState.loading) {
          state = StoreState.success;
        }
      } else {
        errorMsg = res.error!.getErrorMessage();
        state = StoreState.error;
      }
      isLoading = false;
    }
  }

  void reset() {
    currentPage = 1;
    itemList.clear();
    isLoading = false;
  }

  void dispose() {
    scrollController.dispose();
  }
}
