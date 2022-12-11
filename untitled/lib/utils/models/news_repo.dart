import 'dart:developer';

import '../api_handler.dart';
import '../api_routes.dart';
import 'get_news_model.dart';
import 'package:NewsApp/utils/overlayLoading.dart';


class NewsRepo {

  static Future<Everything?> topNews() async {

    var responseBody = await API.apiHandler(
      showLoader: true,
      url: APIRoutes.topNewsUrl+APIRoutes.newsApiKey,
      requestType: RequestApiType.get,
    );
    if (responseBody != null) {
      return Everything.fromJson(responseBody);
    } else {
      return null;
    }
  }
  static Future<Everything?> allNews() async {
    var responseBody = await API.apiHandler(
      showLoader: true,
      url: APIRoutes.allNewsUrl+APIRoutes.newsApiKey,
      requestType: RequestApiType.get,
    );
    if (responseBody != null) {
      return Everything.fromJson(responseBody);
    } else {
      return null;
    }
  }
  static Future<Everything?> search(String? query) async {
    var responseBody = await API.apiHandler(
      showLoader: true,
      url: "${APIRoutes.searchUrl}${query!}&apiKey=${APIRoutes.newsApiKey}",
      requestType: RequestApiType.get,
    );
    if (responseBody != null) {
      return Everything.fromJson(responseBody);
    } else {
      return null;
    }
  }

}