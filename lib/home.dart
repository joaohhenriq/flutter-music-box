import 'package:flutter/material.dart';
import 'package:flutter_music_box/grid_control.dart';
import 'package:flutter_music_box/grid_size.dart';
import 'package:flutter_music_box/grid_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Flutter Music Box"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridWidget(gridSize: GridSize.size),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: GridControl(),
            ),
          ],
        ),
      ),
    );
  }
}
