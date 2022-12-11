import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  set isOpen(bool value) {
    _isOpen = value;
    update();
  }

  int _lasIndex = 0;

  int get lasIndex => _lasIndex;

  set lasIndex(int value) {
    _lasIndex = value;
    update();
  }

  bool _onSearchTap = false;
  bool get onSearchTap => _onSearchTap;
  set onSearchTap(bool value) {
    _onSearchTap = value;
    update();
  }

  List _searchResults=[];
  List get searchResults => _searchResults;
  set searchResults(List value) {
    _searchResults = value;
    update();
  }

  List _searchableList=[];
  List get searchableList => _searchableList;
  set searchableList(List value) {
    _searchableList = value;
    update();
  }
}