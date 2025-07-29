import 'package:flutter/material.dart';
import 'package:flutter_test_package/settingpage.dart';
import 'package:flutter_test_package/slidebar_page.dart';
import 'package:flutter_test_package/web3d_view.dart';

import 'nationality.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        home: SlideBarPage());
  }
}
