import 'package:flutter/material.dart';

Widget BottomNav(pageindex, setindexpage) {
  return SizedBox(
    height: 100,
    child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 15,
          color: Colors.grey,
        ),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          selectedItemColor: Color.fromRGBO(141, 27, 255, 1),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Account",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: "favorite",
            ),
          ],
          currentIndex: pageindex,
          onTap: setindexpage,
        ),
      ),
    ),
  );
}