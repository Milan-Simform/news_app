import 'package:mobx/mobx.dart';
import 'package:news_app/apibase/repository.dart';
import 'package:news_app/models/model.dart';
import 'package:news_app/values/enumeration.dart';

part 'latest_article_store.g.dart';

class LatestArticleStore extends _LatestArticleStore with _$LatestArticleStore {}

abstract class _LatestArticleStore with Store {
  _LatestArticleStore() {
    getLatestArticles();
  }

  final Repository repository = Repository();

  @observable
  StoreState state = StoreState.initial;

  @observable
  String errorMsg = '';

  ObservableList<Article> articleList = ObservableList();

  Future<void> getLatestArticles() async {
    state = StoreState.loading;
    errorMsg = '';
    final res = await repository.getLatestArticles();
    if (res.data != null) {
      articleList.addAll(res.data!);
      state = StoreState.success;
    } else {
      if (res.error != null) {
        errorMsg = res.error!.getErrorMessage();
      }
      state = StoreState.error;
    }
  }
}
