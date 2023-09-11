import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/article_model.dart';
import '../../../models/articles_from_rtdb.dart';
import '../../../models/publisher_model.dart';
import 'home_page_get_controller.dart';

class ArticleTabGetController extends GetxController {
  Future<List<ArticleModel>> loadArticleFromRtdb(String categoryName) async {
    List<ArticleModel> articlesList = [];
    String firebaseUrl =
        "https://veracity-42ed5-default-rtdb.asia-southeast1.firebasedatabase.app/";

    final response = await http.get(Uri.parse("$firebaseUrl/Articles.json"));

    if (response.statusCode == 200) {
      Map<String, dynamic> articles = jsonDecode(response.body);

      articles.forEach((key, value) {
        ArticlesFromRtdb temp = ArticlesFromRtdb.fromJson(value);

        List<String> receivedCategories = temp.category;

        HomePageGetController homePageGetController = Get.find();
        bool containsCategory = receivedCategories.contains(categoryName);

        if (containsCategory) {
          articlesList.add(ArticleModel(
            id: key,
            title: temp.title,
            description: "",
            htmlText: temp.content,
            date: DateTime.fromMillisecondsSinceEpoch(temp.timestamp),
            headlineImageUrl: temp.thumbnailImageUrl,
            youtubeLink: "",
            category: homePageGetController.categories[
                homePageGetController.categories.indexWhere((element) {
              return element.name == categoryName;
            })],
            publisher: PublisherModel(
                name: temp.publisherName,
                email: "email",
                password: "password",
                profilePicLink: "",
                dateCreated: ""),
          ));
        }
      });
    } else {
      throw Exception("Failed to load articles");
    }

    return articlesList;
  }
}
