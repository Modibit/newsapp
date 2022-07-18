// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, file_names

import 'package:NewsApp/Extentions.dart';
import 'package:NewsApp/Functions/getRandomInt.dart';
import 'package:NewsApp/Kits/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Functions/getWeekDay.dart';
import '../Items/MyNews.dart';
import '../Pages/DetailNewsPage.dart';

Widget NewsCard(MyNews appnews, context) {
  return Container(
    width: double.infinity,
    height: 140,
    margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: InkWell(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailNews(
                        appnews: appnews,
                      )));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: appnews.urlToImage,
                          placeholder: (context, url) => SpinKitCircle(
                            color: Colors.redAccent,
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/newspaper.png"),
                          width: 90,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      height: 140,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 1),
                            colors: <Color>[
                              Color.fromARGB(40, 13, 195, 255),
                              // Color.fromARGB(71, 91, 0, 96),
                              Color.fromARGB(101, 156, 6, 236),
                            ]),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appnews.title,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: myColors[
                                    getRandomInt(myColors.length - 1)]),
                            child: Text(
                              appnews.sourceName,
                              style:
                                  TextStyle(fontFamily: "Yekan", fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.black54,
                                size: 15,
                              ),
                              Text(
                                "  ${appnews.time.hour}:${appnews.time.minute} - ${getWeekDay(appnews.time.weekday)}",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ).addNeumorphism(),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailNews(
                                appnews: appnews,
                              )));
                },
                icon: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
            ).addNeumorphism())
      ],
    ),
  );
}
