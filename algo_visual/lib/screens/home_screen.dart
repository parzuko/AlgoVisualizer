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
  var highlightText = [false, true, false];
  var highlightMode = [false, true, false];
////////////////////////////SORTING METHODS/////////////////////////
  // Selection Sort
  selection() async {
    setState(() {
      isSelected = false;
    });
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
    setState(() {
      isSelected = true;
    });
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
    setState(() {
      isSelected = false;
    });
    if (low < high) {
      int pi = partition(arr, low, high);
      await Future.delayed(Duration(microseconds: 15000));
      quickSort(arr, low, pi - 1);
      quickSort(arr, pi + 1, high);
    }
    _streamController.add(_array);

    setState(() {
      isSelected = true;
    });
  }

  // Bubble Sort
  bubble() async {
    setState(() {
      isSelected = false;
    });
    for (int i = 0; i < _array.length; ++i) {
      for (int j = 0; j < _array.length - i - 1; ++j) {
        if (_array[j] > _array[j + 1]) {
          int temp = _array[j];
          _array[j] = _array[j + 1];
          _array[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        _streamController.add(_array);
      }
    }
    setState(() {
      isSelected = true;
    });
  }

  _shuffle() {
    _array = [];
    for (int each = 0; each < _sizeOfArray; each++) {
      _array.add(Random().nextInt(_sizeOfArray.round()));
    }

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
              fontSize: 22.0,
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
                "Frenzy Mode",
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
            FlatButton(
              onPressed: () {
                setState(() {
                  mode = modes["Reverse"];
                });
              },
              child: Text(
                "DownSideUp",
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
        Divider(
          height: 20,
        ),
        ListTile(
          title: Text(
            "Bubble Sort",
            style: TextStyle(
              color: highlightText[0] ? Palette.theButton : Palette.brightText,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
          onTap: () {
            selectSortingMethod("Bubble Sort");
            setState(() {
              for (var each = 0; each < highlightText.length; each++) {
                highlightText[each] = false;
              }
            });
            setState(() => highlightText[0] = !highlightText[0]);
          },
        ),
        ListTile(
          title: Text(
            "Selection Sort",
            style: TextStyle(
              color: highlightText[1] ? Palette.theButton : Palette.brightText,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
          onTap: () {
            selectSortingMethod("Selection Sort");
            setState(() {
              for (var each = 0; each < highlightText.length; each++) {
                highlightText[each] = false;
              }
            });
            setState(() => highlightText[1] = !highlightText[1]);
          },
        ),
        ListTile(
          title: Text(
            "Quick Sort",
            style: TextStyle(
              color: highlightText[2] ? Palette.theButton : Palette.brightText,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
          onTap: () {
            selectSortingMethod("Quick Sort");
            setState(() {
              for (var each = 0; each < highlightText.length; each++) {
                highlightText[each] = false;
              }
            });
            setState(() => highlightText[2] = !highlightText[2]);
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
      sort = (String method) async {
        if (method == "BUBBLE SORT") {
          bubble();
        } else if (method == "SELECTION SORT") {
          selection();
        } else if (method == "QUICK SORT") {
          quickSort(_array, 0, _array.length - 1);
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
                                  if (isSelected) {
                                    _shuffle();
                                  }
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
                            // borderRadius: BorderRadius.only(
                            //   topLeft: const Radius.circular(10),
                            //   topRight: const Radius.circular(10),
                            // ),
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
