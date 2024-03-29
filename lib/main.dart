import 'package:flutter/material.dart';
import 'package:flutter_forms/src/bloc/provider.dart';
import 'package:flutter_forms/src/pages/home_page.dart';
import 'package:flutter_forms/src/pages/login_page.dart';
import 'package:flutter_forms/src/pages/product_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider (
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'product': (BuildContext context) => ProductPage()
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}