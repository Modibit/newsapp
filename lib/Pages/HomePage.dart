import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import '../Items/MyNews.dart';
import '../Kits/Cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static int onPage = 1;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
          elevation: 0,
          leading: Icon(
            Icons.home_filled,
            color: Colors.black54,
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                myRefreshState();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => myRefreshState(),
          child: FutureBuilder<bool>(
            future: getapinews(HomePage.onPage),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      //myNews.clear;
                      if (index != myNews.length)
                        return NewsCard(myNews[index], context);
                      return Container(
                          margin: EdgeInsets.only(
                              left: 100, right: 100, top: 10, bottom: 10),
                          child: ElevatedButton(
                            child: Text("Load More"),
                            onPressed: () {
                              HomePage.onPage++;
                              setState(() {});
                            },
                          ));
                    },
                    itemCount: myNews.length + 1,
                  );
                } else {
                  Center(
                    child: Text("Error"),
                  );
                }
              }

              return SpinKitCircle(
                color: Colors.blue,
              );
            },
          ))
    );
  }
    Future<bool> myRefreshState() async {
    await getapinews(1);
    setState(() {});
    return true;
  }
   Future<bool> getapinews(page) async {
    // if (firstget) return;
    Response response = await get(Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d3142f6d8ad4470992ddf9e1ea969f7e&page=$page",
    ));
    if (response.statusCode != 200) return false;
    var body = jsonDecode(utf8.decode(response.bodyBytes));
    if (page == 1) myNews.clear();

    for (var data in body["articles"]) {
      myNews.add(MyNews(
          data["source"]["name"],
          data["title"].toString(),
          data["description"].toString(),
          data["content"].toString(),
          data["url"].toString(),
          data["urlToImage"].toString(),
          data["publishedAt"].toString()));

      print(myNews[myNews.length - 1].urlToImage);
    }
    //setState(() {});

    Future.delayed(Duration.zero, () async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("List Updated"),
        duration: Duration(milliseconds: 500),
      ));
    });
    return true;
    // firstget = true;
  }
}
