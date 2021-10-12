import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dose_care/models/article.dart';

class NetworkHelper {
  List<Article> news = [];
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    var response = await Dio().get(
      url,
    );
    var jsonData = response.data["articles"];
    int i = 0;
    jsonData.forEach((element) {
      if (element['urlToImage'] != null &&
          element['description'] != null &&
          i < 7) {
        i++;
        Article article = Article(
          title: element['title'],
          author: element['author'],
          description: element['description'],
          urlToImage: element['urlToImage'],
          publshedAt: DateTime.parse(element['publishedAt']),
          content: element["content"],
          articleUrl: element["url"],
        );
        news.add(article);
      }
    });
    // try {
    //   if (response.statusCode == 200) {
    //     news = response.data["articles"];
    //     // print(jsonDecode(news));
    //     // return jsonDecode(data);
    //     return jsonData;
    //   }
    // } on DioError catch (e) {
    //   print(e);
    // }
    return news;
  }
}
