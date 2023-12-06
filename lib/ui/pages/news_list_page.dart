import 'package:flutter/material.dart';

import '../../model/article_model.dart';
import 'article_detail_page.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/articles.json'),
          builder: (context, snapshot) {
            final List<ArticleModel> articles = parseArticles(snapshot.data);
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _buildArticleItem(context, articles[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, ArticleModel article) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ArticleDetailPage(
              article: article,
            );
          },
        ));
      },
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage!,
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
      title: Text(article.title!),
      subtitle: Text(article.author!),
    );
  }
}
