import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter_midi/flutter_midi.dart';

final scale = [48, 50, 52, 55, 57, 60];

class GridProvider extends ChangeNotifier {
  final int gridSize;
  final int playSpeed;

  GridProvider({this.gridSize = 6, this.playSpeed = 150}){
    _midiNotes = List.generate(gridSize, (row){
      return scale[row % 5] + 12 * (row / 5).floor();
    });

//    rootBundle.load("assets/Dance Trance.sf2").then((sf2){
//      FlutterMidi.prepare(sf2: sf2, name: "Dance Trance.sf2");
//    });

    rootBundle.load("assets/Perfect_Sine.sf2").then((sf2){
      FlutterMidi.prepare(sf2: sf2, name: "Perfect_Sine.sf2");
    });
  }

  StreamSubscription _subscription;
  var _selectedColumn = 0;
  var _seletedButtons = Map<int, Map<int, bool>>();
  List<int> _midiNotes;

  bool get isPlaying => _subscription != null && !_subscription.isPaused;

  bool isButtonTrigerred(int column, int row) {
    return isButtonSelected(column, row) && column == _selectedColumn;
  }

  bool isButtonSelected(int column, int row) {
    if (!_seletedButtons.containsKey(column) ||
        !_seletedButtons[column].containsKey(row)) {
      return false;
    }

    return _seletedButtons[column][row];
  }

  void addButton(int column, int row) {
    if (!_seletedButtons.containsKey(column)) {
      _seletedButtons[column] = Map<int, bool>();
    }

    _seletedButtons[column][row] = true;
    notifyListeners();
  }

  void removeButton(int column, int row) {
    _seletedButtons[column][row] = false;
    notifyListeners();
  }

  void play() {
    _subscription?.cancel();

    _subscription = Stream.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) => playMidiNotes());
  }

  void reset() {
    _subscription?.pause();
    _seletedButtons = new Map<int, Map<int, bool>>();
    notifyListeners();
  }

  void pause() {
    _subscription.pause();
    notifyListeners();
  }

  void playMidiNotes() {
    _selectedColumn = (_selectedColumn + 1) % gridSize;

    _seletedButtons[_selectedColumn]?.forEach((row, isSelected) {
      if (isSelected) {
        FlutterMidi.playMidiNote(midi: _midiNotes[row]);

        Future.delayed(Duration(milliseconds: 100),
                () => FlutterMidi.stopMidiNote(midi: _midiNotes[row]));
      }
    });

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
