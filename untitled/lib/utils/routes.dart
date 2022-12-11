import 'package:get/get.dart';
import '../screen/Basescreen/basescreen.dart';
import '../screen/homescreen/home_screen.dart';
import '../screen/homescreen/search_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: BaseScreen.routeName, page: () => BaseScreen()),
  GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
  GetPage(name: SearchScreen.routeName, page: () => SearchScreen()),
];
