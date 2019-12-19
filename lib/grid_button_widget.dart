import 'package:flutter/material.dart';
import 'package:flutter_music_box/grid_provider.dart';
import 'package:flutter_music_box/grid_size.dart';
import 'package:provider/provider.dart';

class GridButtonWidget extends StatelessWidget {
  final int row;
  final int column;

  const GridButtonWidget(this.row, this.column, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GridProvider>(
      builder: (context, grid, child) {
        final isTriggered = grid.isButtonTrigerred(column, row);

        final color = isTriggered
            ? Color(0xFFa3c3d9).withOpacity(0.5)
            : grid.isButtonSelected(column, row)
            ? Color(0xFFa3c3d9)
            : Colors.white;

        return AnimatedContainer(
          duration: Duration(milliseconds: 125),
          width: GridSize.buttonWidth,
          height: GridSize.buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: !isTriggered
                ? Border.all(width: 2.0, color: Color(0xFF3e3e3e))
                : null,
            boxShadow: isTriggered
                ? [
              BoxShadow(
                blurRadius: 12.0,
                spreadRadius: 2.0,
                color: Colors.white,
              ),
            ]
                : [],
            color: color,
          ),
        );
      },
    );
  }
}
