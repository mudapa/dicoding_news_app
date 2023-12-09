import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/article_model.dart';

class ArticleService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '4ad6448c20274ba1b9d68ffec7df562f';
  static const String _category = 'business';
  static const String _country = 'us';

  Future<ArticleModel> topHeadlines() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return ArticleModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
