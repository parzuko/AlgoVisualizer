import 'dart:async';
import 'dart:math';

//import 'package:algo_visual/algos/selection.dart';
import 'package:algo_visual/config/numbers.dart';
import 'package:algo_visual/config/palette.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _array = [];
  double _sizeOfArray = 500;

  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;

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
      //setState(() {});
      _streamController.add(_array);
    }
  }

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
    for (int each = 0; each < 500; each++) {
      _array.add(Random().nextInt(_sizeOfArray.round()));
    }

    //setState(() {});
    _streamController.add(_array);
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
                        // barWidth: 2.0,
                        barWidth:
                            MediaQuery.of(context).size.width / _sizeOfArray,
                        elementValue: item,
                        elementIndex: counter,
                        maxVal: _sizeOfArray.round(),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 550.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.shuffle,
                        ),
                        iconSize: 50.0,
                        color: Palette.textColor,
                        onPressed: _shuffle,
                      ),
                    ),
                    Slider(
                      value: _sizeOfArray,
                      min: 100,
                      max: 500,
                      divisions: 4,
                      inactiveColor: Palette.textColor,
                      activeColor: Palette.theButton,
                      label: "Set Size Of Array To: ${_sizeOfArray.round()}",
                      onChanged: (double value) {
                        setState(() {
                          _sizeOfArray = value;
                          _shuffle();
                        });
                        //_sizeOfArray = value;
                      },
                    ),
                  ],
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
              onPressed: bubble,
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
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
              onPressed: () {},
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
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
              onPressed: selection,
            ),
          ),
        ],
      ),
    );
  }
}
