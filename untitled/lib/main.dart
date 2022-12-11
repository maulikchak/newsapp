import '../../utils/global.dart';
import 'package:NewsApp/screen/Basescreen/basescreen.dart';
import 'package:NewsApp/utils/bindings.dart';
import 'package:NewsApp/utils/global.dart';
import 'package:NewsApp/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // globalVerbInit();
  await GetStorage.init();
  await getInitialRoute();
  runApp(const MyApp());
}

getInitialRoute() async {
  // if (LocalStorage.getUserDetails()) {
  initialRoute = BaseScreen.routeName;
  // userController.refreshToken();
  // } else {
  //   initialRoute = LoginScreen.routeName;
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'NewsApp',
      debugShowCheckedModeBanner: false,
      initialBinding: BaseBinding(),
      initialRoute: initialRoute,
      getPages: routes,
    );
  }
}
