import 'package:flutter/material.dart';

import '../../model/article_model.dart';
import '../../share/style.dart';
import '../pages/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Text(
            article.title!,
          ),
          subtitle: Text(article.author ?? ""),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ArticleDetailPage(
                  article: article,
                );
              },
            ));
          }),
    );
  }
}