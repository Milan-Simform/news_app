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
  }

  final Repository repository = Repository();

  @observable
  int currentIndex = 0;

  @observable
  StoreState state = StoreState.initial;

  @observable
  String errorMsg = '';

  ObservableList<Article> articleList = ObservableList();

  Future<void> getTopicWiseArticles(String topic) async {
    state = StoreState.loading;
    errorMsg = '';
    final res = await repository.getTopicWiseArticles(
      page: 1,
      topic: topic.toLowerCase(),
    );
    if (res.data != null) {
      articleList..clear()
      ..addAll(res.data!);
      state = StoreState.success;
    } else {
      if (res.error != null) {
        errorMsg = res.error!.getErrorMessage();
      }
      state = StoreState.error;
    }
  }
}
