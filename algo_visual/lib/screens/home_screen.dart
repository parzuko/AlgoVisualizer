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
  String currentSortingMethod = "Selection Sort";
  double _sizeOfArray = 500;
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;
  int color = 1;
  bool isSelected = true;
////////////////////////////SORTING METHODS/////////////////////////

  bool isSorted(List<int> a) {
    int i = a.length - 1;
    if (i <= 0) return true;
    if ((i & 1) > 0) {
      if (a[i] < a[i - 1]) return false;
      i--;
    }
    for (int ai = a[i]; i > 0; i -= 2)
      if (ai < (ai = a[i - 1]) || ai < (ai = a[i - 2])) return false;
    return a[0] <= a[1];
  }

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
    setState(() {
      isSelected = true;
    });
    _streamController.add(_array);
  }

////////////////////////////UTLITIY METHODS/////////////////////////
  final modes = {
    "Normal": 1,
    "Frenzy": 2,
    "Reverse": 3,
  };
  int mode = 1;
  Column showBottomNavigationMenu() {
    return Column(
      children: [
        Text(
          "Mode",
          style: TextStyle(
              color: Palette.scaffold,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontFamily: 'Segoe UI'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              onPressed: () {
                setState(() {
                  mode = modes["Frenzy"];
                });
              },
              child: Text(
                "Frenzy",
                style: TextStyle(
                    color: Palette.scaffold,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'Segoe UI'),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  mode = modes["Normal"];
                });
              },
              child: Text(
                "Standard",
                style: TextStyle(
                    color: Palette.scaffold,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'Segoe UI'),
              ),
            ),
          ],
        ),
        ListTile(
          title: Text(
            "Bubble Sort",
          ),
          onTap: () {
            selectSortingMethod("Bubble Sort");
            //bubble();
          },
        ),
        ListTile(
          title: Text(
            "Selection Sort",
          ),
          onTap: () {
            selectSortingMethod("Selection Sort");

            //bubble();
          },
        ),
        ListTile(
          title: Text("Quick Sort"),
          onTap: () {
            selectSortingMethod("Quick Sort");
            //bubble();
          },
        ),
        ListTile(
          title: Text("Mast Sort"),
          onTap: () {
            selectSortingMethod("Mast Sort");
            //bubble();
          },
        ),
        ListTile(
          title: Text("Recursive Sort"),
          onTap: () {
            selectSortingMethod("Recursive Sort");
            //bubble();
          },
        ),
      ],
    );
  }

  void selectSortingMethod(String methodName) {
    //Navigator.pop(context);
    setState(() {
      currentSortingMethod = methodName;
    });
  }

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
          bubble();
          setState(() {
            isSelected = false;
          });
        } else if (method == "SELECTION SORT") {
          selection();
          setState(() {
            isSelected = false;
          });
        } else if (method == "QUICK SORT") {
          quickSort(_array, 0, _array.length - 1);
          setState(() {
            isSelected = false;
          });
        }
      };
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
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
                        whichColor: color,
                        whichMode: mode,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
      bottomNavigationBar: DraggableScrollableSheet(
        initialChildSize: 0.065,
        minChildSize: 0.065,
        maxChildSize: 0.5,
        builder: (context, controller) {
          return Container(
              decoration: BoxDecoration(color: Palette.textColor),
              child: ListView.builder(
                itemCount: 1,
                controller: controller,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      BottomAppBar(
                        color: Palette.theButton,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  if (currentSortingMethod == "Bubble Sort") {
                                    try {
                                      sort("BUBBLE SORT");
                                    } catch (NoSuchMethodError) {}
                                  } else if (currentSortingMethod ==
                                      "Selection Sort") {
                                    try {
                                      sort("SELECTION SORT");
                                    } catch (NoSuchMethodError) {}
                                  } else {
                                    try {
                                      sort("QUICK SORT");
                                    } catch (NoSuchMethodError) {}
                                  }
                                },
                                child: Text(
                                  currentSortingMethod,
                                  style: TextStyle(
                                    color: Palette.textColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.shuffle),
                                iconSize: 30.0,
                                color: Palette.textColor,
                                onPressed: () {
                                  _shuffle();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.settings),
                                iconSize: 30.0,
                                color: Palette.textColor,
                                onPressed: showSettingsPage,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 400,
                        color: Palette.scaffold,
                        child: Container(
                          child: showBottomNavigationMenu(),
                          decoration: BoxDecoration(
                            color: Palette.textColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ));
        },
      ),
    );
  }
}
