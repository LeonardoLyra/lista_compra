import 'package:flutter/material.dart';
import 'package:lista_compra/views/add.page.dart';
import 'package:lista_compra/views/edit.page.dart';
import 'package:lista_compra/views/home.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddPage(),
        '/edit': (context) => EditPage(),
      },
      initialRoute: '/',
    );
  }
}
