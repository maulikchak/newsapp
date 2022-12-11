import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/global.dart';
import '../utils/overlayLoading.dart';
import 'api_routes.dart';

enum RequestApiType { get, post, put }

class API {
  static late http.Response response;

  static Future<Map<String, dynamic>?> apiHandler({
    required String url,
    RequestApiType requestType = RequestApiType.post,
    bool showLoader = true,
    bool showToast = false,
    dynamic body,
  }) async {
    if (await checkConnection()) {
      if (showLoader) LoadingOverlay.of().show();
      log("URl ===> $url");
      log("HEADER ===> ");
      log("BODY ===> $body");

      if (requestType == RequestApiType.get) {
        response = await http.get(
          Uri.parse(url),
        );
      } else if (requestType == RequestApiType.post) {
        response = await http.post(Uri.parse(url),
            headers:
                 {

                    "Content-Type": "application/json",

                  },
            body: body);
      } else if (requestType == RequestApiType.put) {
        response = await http.put(Uri.parse(url),
            headers:
                {

                    "Content-Type": "application/json",
                  },
            body: body);
      }
      log("RETURN RESPONSE BODY ===> ${response.body}");
      var responseDecode = json.decode(response.body);
      log("RETURN RESPONSE DECODE BODY ===> $responseDecode");
      if (showLoader) LoadingOverlay.of().hide();
      if (showToast) {
        flutterToast(responseDecode["message"] ?? "api_error_msg".tr);
      }
      if (response.statusCode == 200) {
        return responseDecode;
      } else if (response.statusCode == 400 ) {
        return responseDecode;
      }
      else if (response.statusCode == 403) {
            apiHandler(
                url: url,
                requestType: requestType,
                body: body,
                showToast: showToast,
                showLoader: showLoader);
          }

    } else {
      flutterToast('check_your_connection'.tr);
    }
    // if (showLoader) LoadingOverlay.of().hide();
    return null;
  }


}
