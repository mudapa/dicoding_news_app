import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/article_model.dart';
import '../widgets/platform_widget.dart';
import 'article_detail_page.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
      builder: (context, snapshot) {
        final List<ArticleModel> articles = parseArticles(snapshot.data);
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return _buildArticleItem(context, articles[index]);
          },
        );
      },
    );
  }

  Widget _buildArticleItem(BuildContext context, ArticleModel article) {
    return Material(
      child: ListTile(
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
        leading: Hero(
          tag: article.urlToImage!,
          child: Image.network(
            article.urlToImage!,
            width: 100,
            errorBuilder: (ctx, error, _) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        title: Text(article.title!),
        subtitle: Text(article.author!),
      ),
    );
  }
}
