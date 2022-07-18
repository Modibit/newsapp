// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:NewsApp/Kits/Cards.dart';
import 'package:flutter/material.dart';

import '../Items/FavoriteList.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Favorites",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                //  getapinews();
              });
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          print("set state");
          if (FavoriteList.getInstance().getFavoritList.length == 0) {
            return Center(
              child: Text(
                "Nothing In Your Favorite",
                style: TextStyle(fontFamily: "Yekan", fontSize: 40),
              ),
            );
          } else {
            return NewsCard(
                FavoriteList.getInstance().getFavoritList[index], context);
          }
        },
        itemCount: FavoriteList.getInstance().getFavoritList.length == 0
            ? 1
            : FavoriteList.getInstance().getFavoritList.length,
      ),
    );
  }
}
