import 'dart:developer';

import 'package:NewsApp/screen/homescreen/widget/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/comman_string.dart';
import '../../utils/global.dart';
import '../../utils/overlayLoading.dart';
import '../../utils/size_config.dart';
import 'controller/homescreen_controller.dart';
import 'controller/news_controller.dart';
import 'widget/web_view_news.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  HomeScreen({super.key, this.isAllNews});
  bool? isAllNews;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetAllNewsController getAllNewsController = Get.find<GetAllNewsController>();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  TextEditingController searchInput = TextEditingController();

  @override
  void initState() {
    // LoadingOverlay.of().show();
    // if (widget.isAllNews==false) {
    init();
    // }else{
    // }
    // LoadingOverlay.of().hide();
    super.initState();
  }


  init() async {
    await getAllNewsController.topNewsGet();
    await getAllNewsController.allNewsGet();
  }

  @override
  Widget build(BuildContext context) {
    getAllNewsController.topNews.shuffle();
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        // foregroundColor: Colors.black,
        centerTitle: true,
          title:  Text(widget.isAllNews!?'All News':'Trending News'),
          actions: [
            IconButton(
              onPressed: () {
                //
                // getAllNewsController.topNews.shuffle();
                // getAllNewsController.allNews.shuffle();
              },
              icon: const Icon(Icons.thumb_up),
            ),
          ],
          backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const AlwaysScrollableScrollPhysics(),

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// search bar
          widget.isAllNews!?Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder(
              builder: (HomeScreenController controller) {
                return SizedBox(
                  height: getHeight(50),
                  child: TextField(
                      controller: searchInput,
                      onChanged: (String? value) {
                        if (value!.isEmpty) {
                          controller.searchResults = [];
                          controller.onSearchTap = false;
                        } else {
                          controller.onSearchTap = true;
                          controller.searchResults = [];
                          controller.searchResults =
                              controller.searchableList.where((element) {
                            var data = element.address.toString().toLowerCase();
                            return data.contains(value);
                          }).toList();
                        }
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 3),
                          hintText: "Search",
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 32,
                            color: Colors.white,
                          ),
                          suffixIcon: homeScreenController.onSearchTap
                              ? GestureDetector(
                                  onTap: () {
                                    searchInput.clear();
                                    controller.searchResults = [];
                                    controller.onSearchTap == false;
                                    disposeKeyboard();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 25,
                                    color: Colors.blue,
                                  ),
                                )
                              : const SizedBox(),
                          filled: true,
                          fillColor: AppColors.darkModeCommonColor)),
                );
              },
            ),
          ):getSizedBox(h: 10),

          /// coursol slider
          // feature implement

          /// others news
          GetBuilder(
              builder: (GetAllNewsController controller) {
            return  ListView.builder(
                        controller: controller.scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.isAllNews!?controller.allNews.length:controller.topNews.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(() => WebViewNews(
                                newsUrl: widget.isAllNews!?controller.allNews[index].url:controller.topNews[index].url)),
                            child: NewsCard(
                              ontap: () {
                                controller.favNews.add(controller.allNews[index]);
                                log("==>${controller.favNews}");
                                controller.isLike=!controller.isLike;
                                log("==>${controller.isLike}");
                              },
                                color:  controller.isLike?Colors.red:Colors.grey,
                                imgUrl:
                                widget.isAllNews!?controller.allNews[index].urlToImage ?? '':controller.topNews[index].urlToImage ?? '',
                                desc:
                                widget.isAllNews!?controller.allNews[index].description ?? '':
                                    controller.topNews[index].description ?? '',
                                title: widget.isAllNews!?controller.allNews[index].title:controller.topNews[index].title,
                                content:
                                widget.isAllNews!?controller.allNews[index].content ?? '':
                                    controller.topNews[index].content ?? '',
                                postUrl: widget.isAllNews!?controller.allNews[index].url:controller.topNews[index].url),
                          );
                        });
          }),
        ]),
      ),
    );
  }
}
