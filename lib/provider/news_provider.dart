import 'package:flutter/foundation.dart';

import '../model/article_model.dart';
import '../services/article_service.dart';
import '../share/result_state.dart';

class NewsProvider extends ChangeNotifier {
  final ArticleService articleService;

  NewsProvider({required this.articleService}) {
    _fetchAllArticle();
  }

  late ArticleModel _articleModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ArticleModel get result => _articleModel;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await articleService.topHeadlines();
      if (article.articles!.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _articleModel = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
