class Article {
  String author;
  String title;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    required this.author,
    required this.title,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"] ?? 'Anonymous',
        title: json["title"] ?? 'null',
        urlToImage: json["urlToImage"] ??
            'https://tacm.com/wp-content/uploads/2018/01/no-image-available.jpeg',
        publishedAt: json["publishedAt"] ?? 'null',
        content: json["content"] ?? 'null',
      );
}
