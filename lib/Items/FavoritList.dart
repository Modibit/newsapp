import 'package:flutter/material.dart';


import 'MyNews.dart';

class FavoritList {
  static FavoritList _instance = FavoritList();
  late List<MyNews> _favorites;
  FavoritList() {
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

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Added To Favorites"),
        duration: Duration(milliseconds: 500),
          ));
    }
  }

  get getFavoritList => _favorites;
  static FavoritList getInstance() {
    if (_instance == null) _instance = FavoritList();
    return _instance;
  }
}
