// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'MyNews.dart';

class FavoriteList {
  static FavoriteList _instance = FavoriteList();
  late List<MyNews> _favorites;
  late bool _reloadEvent = false;
  FavoriteList() {
    _favorites = <MyNews>[];
  }
  bool getInList(MyNews value) => _favorites.contains(value);
  void setFavoriteList(MyNews value, context) {
    if (getInList(value)) {
      _favorites.remove(value);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Removed From Favorites"),
        duration: Duration(milliseconds: 500),
      ));
    } else {
      _favorites.add(value);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Added To Favorites"),
        duration: Duration(milliseconds: 500),
      ));
    }
  }

  bool reloadEvent() {
    if (_reloadEvent = false) return false;
    _reloadEvent = false;
    return true;
  }

  get getFavoritList => _favorites;
  static FavoriteList getInstance() {
    if (_instance == null) _instance = FavoriteList();
    return _instance;
  }
}
