import 'package:get/get.dart';
import '../screen/Basescreen/base_screen_controller.dart';
import '../screen/Basescreen/usercontroller.dart';
import '../screen/homescreen/controller/homescreen_controller.dart';
import '../screen/homescreen/controller/news_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<BaseController>(() => BaseController(), fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(), fenix: true);
    Get.lazyPut<GetAllNewsController>(() => GetAllNewsController(), fenix: true);
  }
}
