//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'package:uts/Page/home.dart';

 //package letak folder Anda

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      //memangil fungsi home pada file home.dart
      home: Home(),
    );
  }
}