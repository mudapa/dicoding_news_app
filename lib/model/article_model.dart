class ArticleModel {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  ArticleModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: List<Article>.from(json["articles"]
          .map((article) => Article.fromJson(article))
          .where((article) =>
              article.author != null && article.publishedAt != null)),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles":
            List<dynamic>.from(articles!.map((article) => article.toJson())),
      };
}

class Article {
  final String? author;
  final String? title;
  final String? url;
  final DateTime? publishedAt;
  final String? urlToImage;
  final String? description;
  final String? content;

  Article({
    this.author,
    this.title,
    this.url,
    this.publishedAt,
    this.urlToImage,
    this.description,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json["author"],
      title: json["title"],
      url: json["url"],
      publishedAt: DateTime.parse(json["publishedAt"]),
      urlToImage: json["urlToImage"],
      description: json["description"],
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "url": url,
        "publishedAt": publishedAt!.toIso8601String(),
        "urlToImage": urlToImage,
        "description": description,
        "content": content,
      };
}
