import 'package:flutter/material.dart';
import 'package:flutter_music_box/grid_button_widget.dart';
import 'package:flutter_music_box/grid_provider.dart';
import 'package:flutter_music_box/grid_size.dart';
import 'package:provider/provider.dart';

class GridWidget extends StatelessWidget {
  final int gridSize;

  const GridWidget({Key key, this.gridSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = List.generate(
      gridSize,
      (columnIndex) => List.generate(
        gridSize,
        (rowIndex) => GridButtonWidget(
          rowIndex,
          columnIndex,
        ),
      ),
    );

    var buttonGrid = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map(
            (buttonColumn) => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttonColumn,
            ),
          )
          .toList(),
    );

    return GestureDetector(
      onTapDown: (details) {
        int column =
            (details.localPosition.dx / GridSize.divisionWidth).floor();
        int row = (details.localPosition.dy / GridSize.divisionHeight).floor();

        Provider.of<GridProvider>(context).isButtonSelected(column, row)
            ? Provider.of<GridProvider>(context).removeButton(column, row)
            : Provider.of<GridProvider>(context).addButton(column, row);

        print(details.localPosition);
      },
      onPanUpdate: (details) {
        int column =
            (details.localPosition.dx / GridSize.divisionWidth).floor();
        int row = (details.localPosition.dy / GridSize.divisionHeight).floor();

        Provider.of<GridProvider>(context).addButton(column, row);

        print(details.localPosition);
      },
      child: Container(
        padding: EdgeInsets.all(18),
        width: GridSize.width,
        height: GridSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: buttonGrid,
      ),
    );
  }
}
