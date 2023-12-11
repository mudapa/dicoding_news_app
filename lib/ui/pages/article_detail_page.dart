import 'package:flutter/material.dart';

import '../../model/article_model.dart';
import '../../share/navigation.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  const ArticleDetailPage({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article.urlToImage!,
              child: Image.network(article.urlToImage!),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: Colors.grey),
                  Text(
                    article.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('Date: ${article.publishedAt}'),
                  const SizedBox(height: 10),
                  Text('Author: ${article.author}'),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    article.content!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  ElevatedButton(
                    child: const Text('Read more'),
                    onPressed: () {
                      Navigation.intentWithData(
                          '/article_web_view', article.url!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
