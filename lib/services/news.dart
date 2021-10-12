import 'networking.dart';

class NewsModel {
  Future<dynamic> getNews() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://newsapi.org/v2/everything?q=health&apiKey=dd565a4092f74cca8c31dc7a214c63b6');
    var newsData = await networkHelper.getData();
    return newsData;
  }
}
