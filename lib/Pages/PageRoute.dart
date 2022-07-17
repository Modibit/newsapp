// ignore_for_file: file_names

import 'HomePage.dart';
import 'package:flutter/material.dart';
import 'AccountPage.dart';
import 'FavoritePage.dart';

int pageIndex = 0;

final List<Widget> pages = [AccountPage(), HomePage(), FavoritePage()];
void setIndexPage(index, context) {
  if (pageIndex == index) return;
  pageIndex = index;
  //print(index);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pages[index - 1]),
      (route) => false);
}
