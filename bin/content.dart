import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

List<Article> articlesFromJson(String str) => List<Article>.from(jsonDecode(str).map((x)=>Article.fromJson(x)));

String articlesToJson(List<Article> data)=> json.encode(List<dynamic>.from(data.map((x)=>x.toJson())));




class Article {
  final String title;
  final String content;
  Article({required this.title, required this.content});

  factory Article.fromJson(Map<String, dynamic> param) => Article(
      title: param['title'], content: param['content']);

  Map<String, dynamic> toJson()=> {
    'title' : title,
    'content' : content,
  };
}