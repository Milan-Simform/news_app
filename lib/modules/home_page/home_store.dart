import 'package:mobx/mobx.dart';
import 'package:news_app/apibase/repository.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore {}

abstract class _HomeStore with Store {
  final Repository repository = Repository();
}
