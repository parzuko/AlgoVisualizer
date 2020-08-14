import 'dart:math';

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

  _shuffle() {
    _array = [];
    for (int each = 0; each < 500; each++) {
      _array.add(Random().nextInt(_sizeOfArray.round()));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: _array.map((int item) {
              counter++;
              return CustomPaint(
                painter: NumberViewer(
                  // barWidth: 2.0,
                  barWidth: MediaQuery.of(context).size.width / _sizeOfArray,
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
                min: 10,
                max: 500,
                divisions: 3,
                inactiveColor: Palette.textColor,
                activeColor: Palette.theButton,
                label: "Set Size Of Array To: ${_sizeOfArray.round()}",
                onChanged: (double value) {
                  setState(() {
                    _sizeOfArray = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
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
              onPressed: () {},
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
