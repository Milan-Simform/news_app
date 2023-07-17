import 'package:flutter/material.dart';
import 'package:news_app/models/model.dart';

class LatestArticleTile extends StatelessWidget {
  const LatestArticleTile({required this.article, super.key});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: 2,
        shadowColor: Colors.grey.shade100,
        // color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 270,
          height: 270,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            // color: Colors.red.shade300,
            borderRadius: BorderRadius.circular(15),
          ),
          // color: Colors.red,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.network(
                  article.media!,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#Trending no.1',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          Text(
                            article.publishedDate!.day.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                      Text(
                        article.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            article.author!,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.grey.shade500,
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
