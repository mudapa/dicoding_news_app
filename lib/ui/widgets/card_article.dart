import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/article_model.dart';
import '../../provider/database_provider.dart';
import '../../share/navigation.dart';
import '../../share/style.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (BuildContext context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isBookmarked(article.url!),
            builder: (context, snapshot) {
              var isBookmarked = snapshot.data ?? false;
              return Material(
                color: primaryColor,
                child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    leading: Hero(
                      tag: article.urlToImage ??
                          "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg",
                      child: Image.network(
                        article.urlToImage ??
                            "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg",
                        width: 100,
                      ),
                    ),
                    title: Text(
                      article.title!,
                    ),
                    subtitle: Text(article.author ?? ""),
                    trailing: isBookmarked
                        ? IconButton(
                            icon: const Icon(Icons.bookmark),
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () =>
                                provider.removeBookmark(article.url!),
                          )
                        : IconButton(
                            icon: const Icon(Icons.bookmark_border),
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () => provider.addBookmark(article),
                          ),
                    onTap: () {
                      Navigation.intentWithData(
                          '/article_detail_page', article);
                    }),
              );
            });
      },
    );
  }
}
