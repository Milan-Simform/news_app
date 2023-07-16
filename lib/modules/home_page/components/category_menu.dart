import 'package:flutter/material.dart';

class NACategoryMenu extends StatefulWidget {
  const NACategoryMenu({
    required this.categories,
    this.currentIndex = 0,
    super.key,
    this.padding,
    this.selectedMenuColor,
    this.unselectedMenuColor,
  });
  final List<String> categories;
  final EdgeInsetsGeometry? padding;
  final Color? selectedMenuColor;
  final Color? unselectedMenuColor;
  final int currentIndex;

  @override
  State<NACategoryMenu> createState() => _NACategoryMenuState();
}

class _NACategoryMenuState extends State<NACategoryMenu> {
  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

  late int currentIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (_, index) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? widget.selectedMenuColor ?? Theme.of(context).primaryColor
                : widget.unselectedMenuColor ?? Colors.grey.shade200,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() {
                currentIndex = index;
              }),
              borderRadius: BorderRadius.circular(40),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.categories[index],
                    style: currentIndex == index
                        ? Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white.withAlpha(240))
                        : Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
