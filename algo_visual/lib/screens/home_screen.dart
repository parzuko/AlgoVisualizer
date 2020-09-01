import 'dart:async';
import 'dart:math';

//import 'package:algo_visual/algos/selection.dart';
import 'package:algo_visual/config/numbers.dart';
import 'package:algo_visual/config/palette.dart';
import 'package:algo_visual/screens/settings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
////////////////////////////GLBOAL VARIABLES/////////////////////////
  List<int> _array = [];
  double _sizeOfArray = 500;
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;
  int color = 1;
  bool isSelected = true;
////////////////////////////SORTING METHODS/////////////////////////

  // Selection Sort
  selection() async {
    for (int i = 0; i < _array.length - 1; i++) {
      int minIdx = i;
      for (int j = i + 1; j < _array.length - 1; j++) {
        if (_array[minIdx] > _array[j]) {
          minIdx = j;
        }
      }
      int temp = _array[i];
      _array[i] = _array[minIdx];
      _array[minIdx] = temp;
      await Future.delayed(Duration(microseconds: 1000));
      _streamController.add(_array);
    }
  }

  // Partition Method For Quick Sort
  int partition(List arr, int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j < high; j++) {
      if (arr[j] < pivot) {
        i++;
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    }
    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;
    return i + 1;
  }

  // Quick Sort
  quickSort(List arr, int low, int high) async {
    if (low < high) {
      int pi = partition(arr, low, high);
      await Future.delayed(Duration(microseconds: 15000));
      quickSort(arr, low, pi - 1);
      quickSort(arr, pi + 1, high);
    }
    _streamController.add(_array);
  }

  // Bubble Sort
  bubble() async {
    for (int i = 0; i < _array.length; ++i) {
      for (int j = 0; j < _array.length - i - 1; ++j) {
        if (_array[j] > _array[j + 1]) {
          int temp = _array[j];
          _array[j] = _array[j + 1];
          _array[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        // setState(() {});
        _streamController.add(_array);
      }
    }
  }

  _shuffle() {
    _array = [];
    for (int each = 0; each < _sizeOfArray; each++) {
      _array.add(Random().nextInt(_sizeOfArray.round()));
    }
    _streamController.add(_array);
  }

////////////////////////////UTLITIY METHODS/////////////////////////

  void showSettingsPage() async {
    final updatedSettings = await showDialog(
      context: context,
      builder: (context) {
        return SettingsDialog(
          sizeOfArray: _sizeOfArray,
          currentTheme: color,
        );
      },
    );
    if (updatedSettings != null) {
      setState(() {
        _sizeOfArray = updatedSettings[0];
        color = updatedSettings[1];
      });
      _shuffle();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;

    _shuffle();
  }

  @override
  Widget build(BuildContext context) {
    var sort;
    if (isSelected) {
      sort = (String method) {
        if (method == "BUBBLE SORT") {
          setState(() {
            isSelected = false;
          });
          bubble();
          setState(() {
            isSelected = false;
          });
        } else if (method == "SELECTION SORT") {
          setState(() {
            isSelected = false;
          });
          selection();
          setState(() {
            isSelected = false;
          });
        } else if (method == "QUICK SORT") {
          setState(() {
            isSelected = false;
          });
          quickSort(_array, 0, _array.length - 1);
          setState(() {
            isSelected = false;
          });
        }
      };
    }
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<Object>(
          stream: _stream,
          builder: (context, snapshot) {
            int counter = 0;
            return Column(
              children: <Widget>[
                Row(
                  children: _array.map((int item) {
                    counter++;
                    return CustomPaint(
                      painter: NumberViewer(
                        barWidth: screenWidth / _sizeOfArray,
                        elementValue: item,
                        elementIndex: counter,
                        maxVal: _sizeOfArray.round(),
                        whichColor: 2,
                        whichMode: 1,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FlatButton(
              disabledColor: Colors.amber,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "BUBBLE SORT",
                style: const TextStyle(
                  color: Palette.textColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontFamily: 'Segoe UI',
                ),
              ),
              onPressed: () {
                try {
                  sort("BUBBLE SORT");
                } catch (NoSuchMethodError) {}
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              disabledColor: Colors.amber,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "QUICK SORT",
                style: const TextStyle(
                  color: Palette.textColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontFamily: 'Segoe UI',
                ),
              ),
              onPressed: () {
                try {
                  sort("QUICK SORT");
                } catch (NoSuchMethodError) {}
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              disabledColor: Colors.amber,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "SELECTION SORT",
                style: const TextStyle(
                  color: Palette.textColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontFamily: 'Segoe UI',
                ),
              ),
              onPressed: () {
                try {
                  sort("SELECTION SORT");
                } catch (NoSuchMethodError) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
