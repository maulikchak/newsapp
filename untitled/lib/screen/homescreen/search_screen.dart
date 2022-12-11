import 'dart:developer';

import 'package:NewsApp/screen/homescreen/widget/news_card.dart';
import 'package:NewsApp/screen/homescreen/widget/web_view_news.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/comman_string.dart';
import '../../utils/global.dart';
import '../../utils/size_config.dart';
import 'controller/homescreen_controller.dart';
import 'controller/news_controller.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/SearchScreen";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GetAllNewsController getAllNewsController = Get.find<GetAllNewsController>();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  TextEditingController searchInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // foregroundColor: Colors.black,
          centerTitle: true,
          title: Text('Search News'),
          actions: [
            IconButton(
              onPressed: () {
                // getAllNewsController.searchNewsGet();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder(
              builder: (GetAllNewsController controller) {
                return SizedBox(
                  height: getHeight(50),
                  child: TextField(
                      controller: searchInput,
                      onChanged: (String? value) {
                        if (value!.isEmpty) {
                          controller.searchNews = [];
                          controller.onSearchTap = false;
                        } else {
                          controller.onSearchTap = true;
                          controller.searchNews = [];
                          controller.query = value;
                          // controller.searchGet(value);
                        }
                      },
                      onSubmitted: (value) async {
                        controller.query = value;
                        controller.searchGet(value);
                        controller.searchNews.clear();
                      },
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 3),
                          hintText: "Search",
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 32,
                            color: Colors.white,
                          ),
                          suffixIcon: controller.onSearchTap
                              ? GestureDetector(
                                  onTap: () {
                                    searchInput.clear();
                                    controller.searchNews = [];
                                    controller.onSearchTap == false;
                                    disposeKeyboard();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(),
                          filled: true,
                          fillColor: AppColors.darkModeCommonColor)),
                );
              },
            ),
          ),

          /// others news
          GetBuilder(builder: (GetAllNewsController controller) {
            return ListView.builder(
                controller: controller.scrollController,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.searchNews.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.to(() =>
                        WebViewNews(newsUrl: controller.searchNews[index].url)),
                    child: NewsCard(
                        ontap: () {
                          controller.favNews.add(controller.allNews[index]);
                          log("==>${controller.favNews}");
                          controller.isLike = !controller.isLike;
                          log("==>${controller.isLike}");
                        },
                        color: controller.isLike ? Colors.red : Colors.grey,
                        imgUrl: controller.searchNews[index].urlToImage ?? '',
                        desc: controller.searchNews[index].description ?? '',
                        title: controller.searchNews[index].title,
                        content: controller.searchNews[index].content ?? '',
                        postUrl: controller.searchNews[index].url),
                  );
                });
          }),
        ]),
      ),
    );
  }
}
