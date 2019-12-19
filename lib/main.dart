import 'package:flutter/material.dart';
import 'package:flutter_music_box/grid_provider.dart';
import 'package:flutter_music_box/grid_size.dart';
import 'package:flutter_music_box/home.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => GridProvider(
        gridSize: GridSize.size
      ),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}