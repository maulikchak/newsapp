import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/comman_string.dart';
import '../../utils/global.dart';
import '../../utils/size_config.dart';
import '../homescreen/controller/news_controller.dart';
import 'base_screen_controller.dart';

class BaseScreen extends StatefulWidget {
  static const String routeName = "/BaseScreen";
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  BaseController baseController = Get.find<BaseController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return  Scaffold(
      body:GetBuilder(
          builder: (BaseController controller) => IndexedStack(
            index: controller.selectedTab,
            children: navigationScreens,
          ),
        ),
      bottomNavigationBar: bottomBar(context),
    );
  }
  BottomAppBar bottomBar(BuildContext context) {
    return BottomAppBar(
      color: AppColors.darkModeCommonColor,
      elevation: 3,
      child: GetBuilder(
        builder: (BaseController controller) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: navigationTabList
                  .asMap()
                  .map(
                    (key, value) => MapEntry(
                  key,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.find<BaseController>().selectedTab = key;
                        if (key == 2) {
                        } else {
                          Get.find<BaseController>().selectedTab = key;
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: getHeight(45),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Icon(value.icon, color: controller.selectedTab == key ? Colors.blue : Colors.grey),
                              ),
                              Text(
                                value.text,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12, color: controller.selectedTab == key ? Colors.blue : Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  .values
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

}
