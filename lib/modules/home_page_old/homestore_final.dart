// import 'package:mobx/mobx.dart';
// import 'package:news_app/apibase/repository.dart';
// import 'package:news_app/models/model.dart';
// import 'package:news_app/modules/home_page/pagination_store.dart';
//
// abstract class _HomeStore extends PaginationStore<Article> with Store {
//   _HomeStore() : super(pageSize: 10);
//
//   final repository = Repository();
//
//   Future<void> fetchArticleData() async {
//     final res =
//         await repository.getLatestArticles(page: page, pageSize: pageSize);
//     if (res.data != null) {
//       super.fetchData(list: res.data!);
//     } else {}
//   }
// }
