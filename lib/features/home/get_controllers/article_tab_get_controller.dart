import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/article_model.dart';

class ArticleTabGetController extends GetxController {
  Future<List<ArticleModel>> loadArticles(String categoryName) async {
    print("Category Name: $categoryName");
    List<ArticleModel> articlesList = [];
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://dailyveracitynews.com/wp-json/wp/v2/category-posts/?category=$categoryName'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      articlesList =
          articleModelFromJson(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    return articlesList;
  }
}
