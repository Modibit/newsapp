// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Kits/BottomNav.dart';
import 'Pages/PageRoute.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      title: 'News App',
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNav(pageIndex, (int index) {
        setState(() {
          pageIndex = index;
        });
      }),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
