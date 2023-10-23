import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/category_model.dart';

class HomePageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<ArticleCategoryModel> categories = <ArticleCategoryModel>[].obs;

  RxInt selectedIndex = 0.obs;

  late TabController tabController;

  void loadCategories() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://dailyveracitynews.com/wp-json/mywebsite/v1/categories/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      categories.value =
          articleCategoryModelFromJson(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void onInit() {
    loadCategories();
    super.onInit();
  }
}
