import 'package:get/get.dart';
import '../../utils/global.dart';

class BaseController extends GetxController {

  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    Future.delayed(Duration.zero, () {
      update();
    });

  }
}
