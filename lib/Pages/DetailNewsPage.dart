// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:NewsApp/Functions/getRandomInt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Functions/getWeekDay.dart';
import '../Items/FavoriteList.dart';
import '../Items/MyNews.dart';
import '../Kits/Colors.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({Key? key, required this.appnews}) : super(key: key);
  final MyNews appnews;

  @override
  _DetailNewsState createState() => _DetailNewsState(appnews);
}

class _DetailNewsState extends State<DetailNews> {
  _DetailNewsState(this.appnews);
  final MyNews appnews;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          CachedNetworkImage(
            height: 6 * MediaQuery.of(context).size.height / 10,
            imageUrl: appnews.urlToImage,
            placeholder: (context, url) => SpinKitCircle(
              color: Colors.grey,
            ),
            errorWidget: (context, url, error) =>
                Image.asset("assets/newspaper.png"),
            fit: BoxFit.cover,
          ),
          Container(
            height: 6 * MediaQuery.of(context).size.height / 10,
            width: double.infinity,
            decoration: BoxDecoration(
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 3 * MediaQuery.of(context).size.height / 5 + 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 3 * MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(90)),
                      color: Colors.white,
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          appnews.title,
                          style: TextStyle(
                              fontFamily: "Yekan",
                              fontWeight: FontWeight.w900,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: myColors[
                                      getRandomInt(myColors.length - 1)]),
                              child: Text(
                                appnews.sourceName,
                                style: TextStyle(
                                    fontFamily: "Yekan", fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.black54,
                              size: 15,
                            ),
                            Text(
                              style:
                                  TextStyle(fontFamily: "Yekan", fontSize: 12),
                              "  ${appnews.time.hour}:${appnews.time.minute} - ${getWeekDay(appnews.time.weekday)}",
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          appnews.content,
                          style: TextStyle(
                              fontFamily: "Yekan",
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Expanded(
                            child: TextButton(
                              onPressed: (() {
                                if (Platform.isAndroid || Platform.isIOS) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          WebViewPage(appnews)));
                                } else {
                                  openLaunchUrl(appnews.url);
                                }
                              }),
                              child: SizedBox(
                                width: 110,
                                height: 20,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Text(
                                      "See Full of News",
                                      style: TextStyle(
                                          fontFamily: "Yekan", fontSize: 12),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 190,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                    color: Color.fromARGB(60, 155, 39, 176),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                                onPressed: (() {
                                  setState(() {
                                    FavoriteList.getInstance()
                                        .setFavoriteList(appnews, context);
                                    print("setstate-detail");
                                  });
                                }),
                                icon: Icon(
                                  FavoriteList.getInstance().getInList(appnews)
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 25,
                                  color: FavoriteList.getInstance()
                                          .getInList(appnews)
                                      ? Colors.red
                                      : Colors.black87,
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                    color: Color.fromARGB(60, 155, 39, 176),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                                onPressed: (() async {
                                  await FlutterShare.share(
                                      title: appnews.title,
                                      text: appnews.content,
                                      linkUrl: appnews.url,
                                      chooserTitle:
                                          'send ${appnews.title} to:');
                                }),
                                icon: Icon(
                                  Icons.send_sharp,
                                  color: Colors.white,
                                  size: 25,
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(),
          )
        ]),
      ),
    );
  }
}

void openLaunchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch';
}

class WebViewPage extends StatelessWidget {
  const WebViewPage(this.post, {Key? key}) : super(key: key);
  final MyNews post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            post.title,
            style: TextStyle(fontFamily: "Yekan", color: Colors.black54),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
              )),
        ),
        body: WebView(initialUrl: post.url));
  }
}
