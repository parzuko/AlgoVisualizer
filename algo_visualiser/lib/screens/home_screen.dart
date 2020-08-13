import 'dart:math';

import 'package:algo_visualizer/config/palette.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _array = [];
  double _sizeOfArray = 100;

  _shuffle() {
    _array = [];
    for (int each = 0; each < _sizeOfArray; each++) {
      _array.add(Random().nextInt(_sizeOfArray.round()));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          
        ];
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.shuffle,
                        ),
                        iconSize: 30.0,
                        color: Palette.textColor,
                        onPressed: () {},
                      ),
                    ),
                    Slider(
                      value: _sizeOfArray,
                      min: 100,
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
