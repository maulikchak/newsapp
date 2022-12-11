import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/models/get_news_model.dart';
import '../../../utils/models/news_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class GetAllNewsController extends GetxController {




  ScrollController scrollController = ScrollController();
  List<Article> _topNews = <Article>[];
  List<Article> _allNews = <Article>[];
  List<Article> _searchNews = <Article>[];
  String _query ="";

  String get query => _query;

  set query(String value) {
    _query = value;
    update();
  }
  bool _onSearchTap =false;

  bool get onSearchTap => _onSearchTap;

  set onSearchTap(bool value) {
    _onSearchTap = value;
    update();
  }

  List<Article> get searchNews => _searchNews;

  set searchNews(List<Article> value) {
    _searchNews = value;
    update();
  }

  List<Article> _favNews = <Article>[];

  List<Article> get favNews => _favNews;

  set favNews(List<Article> value) {
    _favNews = value;
    update();
  }

  List<Article> get allNews => _allNews;

  set allNews(List<Article> value) {
    _allNews = value;
    update();
  }

  List<Source> favSources = <Source>[];

  List<Article> get topNews => _topNews;

  set topNews(List<Article> value) {
    _topNews = value;
    update();
  }
  bool _isLike =false;

  bool get isLike => _isLike;

  set isLike(bool value) {
    _isLike = value;
    update();
  }

  List<Article> breakingNews = <Article>[];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }


  Future<void> topNewsGet() async {
    Everything? everything = await NewsRepo.topNews();

    if (everything != null) {
      topNews = everything.articles;
    }
  }
  Future<void> allNewsGet() async {
    Everything? everything = await NewsRepo.allNews();
    if (everything != null) {
      allNews = everything.articles;
    }
  }
  Future<void> searchGet(String? query) async {
    Everything? everything = await NewsRepo.search(query);
    if (everything != null) {
       searchNews = everything.articles;
    }
  }
}
