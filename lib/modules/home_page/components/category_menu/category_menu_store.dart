import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/utils/extensions.dart';

part 'category_menu_store.g.dart';

class CategoryMenuStore extends _CategoryMenuStore with _$CategoryMenuStore {}

abstract class _CategoryMenuStore with Store {
  @observable
  int currentIndex = 0;

  Future<void> onIndexChanged(
    int index,
    BuildContext context,
    Future<void> call,
  ) async {
    unawaited(
      Scrollable.ensureVisible(
        context,
        alignment: 0.5,
        duration: 500.ms,
      ),
    );
    currentIndex = index;
    unawaited(call);
  }
}
