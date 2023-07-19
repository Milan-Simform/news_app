import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/modules/home_page_old/components/category_menu/category_menu_store.dart';
import 'package:provider/provider.dart';

class NACategoryMenu extends StatelessWidget {
  const NACategoryMenu({
    required this.categories,
    this.currentIndex = 0,
    super.key,
    this.padding,
    this.selectedMenuColor,
    this.unselectedMenuColor,
    this.onTap,
  });

  final List<String> categories;
  final EdgeInsetsGeometry? padding;
  final Color? selectedMenuColor;
  final Color? unselectedMenuColor;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CategoryMenuStore(currentIndex),
      builder: (context, _) {
        final store = context.read<CategoryMenuStore>();
        return SizedBox(
          height: 40,
          child: ListView.separated(
            padding: padding,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(
              width: 8,
            ),
            itemBuilder: (_, index) => Observer(
              builder: (context) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: store.currentIndex == index
                        ? selectedMenuColor ?? Theme.of(context).primaryColor
                        : unselectedMenuColor ?? Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Builder(
                      builder: (context) {
                        return InkWell(
                          onTap: () =>
                              store.onIndexChanged(index, context, onTap),
                          borderRadius: BorderRadius.circular(40),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                categories[index],
                                style: store.currentIndex == index
                                    ? Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.white.withAlpha(240),
                                        )
                                    : Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
