import 'package:algo_visualizer/config/palette.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _array = [];
  double _sizeOfArray = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 0, 0, 20),
            child: SizedBox(
              width: 300.0,
              child: Slider(
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(9, 0, 0, 30),
            child: Expanded(
              child: FlatButton(
                child: Text(
                  "BUBBLE SORT",
                  style: const TextStyle(
                    color: Palette.textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
            child: Expanded(
              child: FlatButton(
                child: Text(
                  "QUICK SORT",
                  style: const TextStyle(
                    color: Palette.textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
            child: Expanded(
              child: FlatButton(
                child: Text(
                  "INSERTION SORT",
                  style: const TextStyle(
                    color: Palette.textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
