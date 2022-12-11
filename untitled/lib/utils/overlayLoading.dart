import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay {
  void hide() {
    Get.back();
  }

  void show() {
    Get.dialog(
      FullScreenLoader(),
      barrierDismissible: false,
    );
    // showDialog(
    //   context: _context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) => FullScreenLoader(),
    // );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create();

  factory LoadingOverlay.of() {
    return LoadingOverlay._create();
  }
}

class FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppLoader(),
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:CircularProgressIndicator()
    );
  }
}


