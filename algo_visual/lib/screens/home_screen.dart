import 'dart:async';
import 'dart:math';

//import 'package:algo_visual/algos/selection.dart';
import 'package:algo_visual/config/numbers.dart';
import 'package:algo_visual/config/palette.dart';
import 'package:algo_visual/config/toastie.dart';
import 'package:algo_visual/screens/settings.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
////////////////////////////GLBOAL VARIABLES/////////////////////////
  AnimationController _animationController;
  bool play_pause = false;
  List<int> _array = [];
  String currentSortingMethod = "Selection Sort";
  double _sizeOfArray = 500;
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;
  int color = 1;
  bool isSelected = true;
  var highlightText = [false, true, false, false];
  var theThemes = [true, false, false, false, false];
  var highlightMode = [false, true, false];
////////////////////////////SORTING METHODS/////////////////////////

  // Insertion Sort
  insertion() async {
    setState(() {
      isSelected = false;
    });
    for (int i = 1; i < _array.length; i++) {
      int key = _array[i];
      int j = i - 1;
      while (j >= 0 && key < _array[j]) {
        _array[j + 1] = _array[j];
        j--;
      }
      await Future.delayed(Duration(microseconds: 10000));
      _streamController.add(_array);
      _array[j + 1] = key;
    }

    setState(() {
      isSelected = true;
    });
  }

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

  void showToast(String msg, {int duration, int gravity}) {
    Toastie.show(msg, context, duration: duration, gravity: gravity);
  }

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
        SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    setState(() {
                      mode = modes["Frenzy"];
                      for (var each = 0; each < highlightMode.length; each++) {
                        highlightMode[each] = false;
                      }
                    });
                    setState(() => highlightMode[0] = !highlightMode[0]);
                  });
                },
                child: Text(
                  "Frenzy Mode",
                  style: TextStyle(
                      color: highlightMode[0]
                          ? Palette.theButton
                          : Palette.scaffold,
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
                    for (var each = 0; each < highlightMode.length; each++) {
                      highlightMode[each] = false;
                    }
                  });
                  setState(() => highlightMode[1] = !highlightMode[1]);
                },
                child: Text(
                  "Standard",
                  style: TextStyle(
                      color: highlightMode[1]
                          ? Palette.theButton
                          : Palette.scaffold,
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
                    for (var each = 0; each < highlightMode.length; each++) {
                      highlightMode[each] = false;
                    }
                  });
                  setState(() => highlightMode[2] = !highlightMode[2]);
                },
                child: Text(
                  "DownSideUp",
                  style: TextStyle(
                      color: highlightMode[2]
                          ? Palette.theButton
                          : Palette.scaffold,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontFamily: 'Segoe UI'),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.bubble_chart,
            color: Palette.scaffold,
            size: 35,
          ),
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
          trailing: Text(
            "Best Time Complexity O(n)",
            style: TextStyle(
              color: highlightText[0] ? Palette.scaffold : Palette.textColor,
              fontSize: 13.0,
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
          leading: Icon(
            Icons.select_all,
            color: Palette.scaffold,
            size: 35,
          ),
          trailing: Text(
            "Best Time Complexity O(n)²",
            style: TextStyle(
              color: highlightText[1] ? Palette.scaffold : Palette.textColor,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
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
          leading: Icon(
            Icons.directions_run,
            color: Palette.scaffold,
            size: 35,
          ),
          trailing: Text(
            "Best Time Complexity O(nlogn)",
            style: TextStyle(
              color: highlightText[2] ? Palette.scaffold : Palette.textColor,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
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
        ListTile(
          leading: Icon(
            Icons.settings_input_svideo,
            color: Palette.scaffold,
            size: 35,
          ),
          trailing: Text(
            "Best Time Complexity O(n)",
            style: TextStyle(
              color: highlightText[3] ? Palette.scaffold : Palette.textColor,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
          title: Text(
            "Insertion Sort",
            style: TextStyle(
              color: highlightText[3] ? Palette.theButton : Palette.brightText,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              fontFamily: 'Segoe UI',
            ),
          ),
          onTap: () {
            selectSortingMethod("Insertion Sort");
            setState(() {
              for (var each = 0; each < highlightText.length; each++) {
                highlightText[each] = false;
              }
            });
            setState(() => highlightText[3] = !highlightText[3]);
          },
        ),
      ],
    );
  }

  void showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(color: Palette.textColor),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, index) {
                return StatefulBuilder(builder: (
                  BuildContext context,
                  StateSetter setModalState,
                ) {
                  return Column(
                    children: [
                      Container(
                        color: Palette.scaffold,
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Mode",
                                style: TextStyle(
                                    color: Palette.scaffold,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: 'Segoe UI'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          mode = modes["Frenzy"];
                                          for (var each = 0;
                                              each < highlightMode.length;
                                              each++) {
                                            highlightMode[each] = false;
                                          }
                                        });
                                        setModalState(() => highlightMode[0] =
                                            !highlightMode[0]);
                                      },
                                      child: Text(
                                        "Frenzy Mode",
                                        style: TextStyle(
                                            color: highlightMode[0]
                                                ? Palette.theButton
                                                : Palette.scaffold,
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
                                          for (var each = 0;
                                              each < highlightMode.length;
                                              each++) {
                                            highlightMode[each] = false;
                                          }
                                        });
                                        setModalState(() => highlightMode[1] =
                                            !highlightMode[1]);
                                      },
                                      child: Text(
                                        "Standard",
                                        style: TextStyle(
                                            color: highlightMode[1]
                                                ? Palette.theButton
                                                : Palette.scaffold,
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
                                          for (var each = 0;
                                              each < highlightMode.length;
                                              each++) {
                                            highlightMode[each] = false;
                                          }
                                        });
                                        setModalState(() => highlightMode[2] =
                                            !highlightMode[2]);
                                      },
                                      child: Text(
                                        "DownSideUp",
                                        style: TextStyle(
                                            color: highlightMode[2]
                                                ? Palette.theButton
                                                : Palette.scaffold,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            fontFamily: 'Segoe UI'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.bubble_chart,
                                  color: Palette.scaffold,
                                  size: 35,
                                ),
                                title: Text(
                                  "Bubble Sort",
                                  style: TextStyle(
                                    color: highlightText[0]
                                        ? Palette.theButton
                                        : Palette.brightText,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                trailing: Text(
                                  "Best Time Complexity O(n)",
                                  style: TextStyle(
                                    color: highlightText[0]
                                        ? Palette.scaffold
                                        : Palette.textColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                onTap: () {
                                  selectSortingMethod("Bubble Sort");
                                  setState(() {
                                    for (var each = 0;
                                        each < highlightText.length;
                                        each++) {
                                      highlightText[each] = false;
                                    }
                                  });
                                  setModalState(() =>
                                      highlightText[0] = !highlightText[0]);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.select_all,
                                  color: Palette.scaffold,
                                  size: 35,
                                ),
                                trailing: Text(
                                  "Best Time Complexity O(n)²",
                                  style: TextStyle(
                                    color: highlightText[1]
                                        ? Palette.scaffold
                                        : Palette.textColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                title: Text(
                                  "Selection Sort",
                                  style: TextStyle(
                                    color: highlightText[1]
                                        ? Palette.theButton
                                        : Palette.brightText,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                onTap: () {
                                  selectSortingMethod("Selection Sort");
                                  setState(() {
                                    for (var each = 0;
                                        each < highlightText.length;
                                        each++) {
                                      highlightText[each] = false;
                                    }
                                  });
                                  setModalState(() =>
                                      highlightText[1] = !highlightText[1]);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.directions_run,
                                  color: Palette.scaffold,
                                  size: 35,
                                ),
                                trailing: Text(
                                  "Best Time Complexity O(nlogn)",
                                  style: TextStyle(
                                    color: highlightText[2]
                                        ? Palette.scaffold
                                        : Palette.textColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                title: Text(
                                  "Quick Sort",
                                  style: TextStyle(
                                    color: highlightText[2]
                                        ? Palette.theButton
                                        : Palette.brightText,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                onTap: () {
                                  selectSortingMethod("Quick Sort");
                                  setState(() {
                                    for (var each = 0;
                                        each < highlightText.length;
                                        each++) {
                                      highlightText[each] = false;
                                    }
                                  });
                                  setModalState(() =>
                                      highlightText[2] = !highlightText[2]);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.settings_input_svideo,
                                  color: Palette.scaffold,
                                  size: 35,
                                ),
                                trailing: Text(
                                  "Best Time Complexity O(n)",
                                  style: TextStyle(
                                    color: highlightText[3]
                                        ? Palette.scaffold
                                        : Palette.textColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                title: Text(
                                  "Insertion Sort",
                                  style: TextStyle(
                                    color: highlightText[3]
                                        ? Palette.theButton
                                        : Palette.brightText,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                                onTap: () {
                                  selectSortingMethod("Insertion Sort");
                                  setState(() {
                                    for (var each = 0;
                                        each < highlightText.length;
                                        each++) {
                                      highlightText[each] = false;
                                    }
                                  });
                                  setModalState(() =>
                                      highlightText[3] = !highlightText[3]);
                                },
                              ),
                              Divider(
                                height: 10,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Palette.textColor,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(25),
                                topRight: const Radius.circular(25),
                              )),
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          );
        });
  }

  void selectSortingMethod(String methodName) {
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
          theThemes: theThemes,
        );
      },
    );
    if (updatedSettings != null) {
      setState(() {
        _sizeOfArray = updatedSettings[0];
        color = updatedSettings[1];
        theThemes = updatedSettings[2];
      });
      _shuffle();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
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
        } else if (method == "INSERTION SORT") {
          insertion();
        }
      };
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final ratioHeight = 65 / screenHeight;
    final containerHeight = 500 / screenHeight;
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: _stream,
          builder: (context, snapshot) {
            int counter = 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: Container(
                    height: 50,
                    color: Palette.textColor,
                    width: screenWidth - 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Current Sorting Method: ",
                          style: TextStyle(
                            color: Palette.brightText,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                        Text(
                          currentSortingMethod,
                          style: TextStyle(
                            color: Palette.scaffold,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: Container(
        height: screenWidth * 0.16,
        width: screenWidth * 0.16,
        child: FloatingActionButton(
          child: Icon(
            Icons.show_chart,
            size: 45,
          ),
          backgroundColor: Palette.brightText,
          onPressed: () {
            if (currentSortingMethod == "Bubble Sort") {
              try {
                sort("BUBBLE SORT");
              } catch (NoSuchMethodError) {}
            } else if (currentSortingMethod == "Selection Sort") {
              try {
                sort("SELECTION SORT");
              } catch (NoSuchMethodError) {}
            } else if (currentSortingMethod == "Insertion Sort") {
              try {
                sort("INSERTION SORT");
              } catch (NoSuchMethodError) {}
            } else {
              try {
                sort("QUICK SORT");
              } catch (NoSuchMethodError) {}
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                onPressed: () => showMenu(),
                icon: Icon(
                  Icons.format_list_bulleted,
                  color: Palette.textColor,
                  size: 30,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AnimatedIconButton(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.fromLTRB(0.5, 0, 0, 0),
                    startIcon: Icon(
                      Icons.cached,
                      color: Palette.textColor,
                    ),
                    endIcon: Icon(
                      Icons.autorenew,
                      color: Palette.textColor,
                    ),
                    size: 30.0,
                    onPressed: () {
                      if (isSelected) {
                        _shuffle();
                      } else {
                        showToast(
                          "$currentSortingMethod In Process.",
                          gravity: Toastie.bottom,
                          duration: Toastie.lengthLong,
                        );
                      }
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
                    icon: Icon(Icons.settings),
                    iconSize: 30.0,
                    color: Palette.textColor,
                    onPressed: () {
                      if (isSelected) {
                        showSettingsPage();
                      } else {
                        showToast(
                          "$currentSortingMethod In Process.",
                          gravity: Toastie.bottom,
                          duration: Toastie.lengthLong,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        color: Palette.theButton,
      ),
    );
  }
}

/**
 * DraggableScrollableSheet(
        initialChildSize: ratioHeight,
        minChildSize: ratioHeight,
        maxChildSize: containerHeight,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedIconButton(
                              animationController: _animationController,
                              size: 30,
                              onPressed: () {
                                showToast(
                                  "Scroll Up For More Options.",
                                  gravity: Toastie.bottom,
                                  duration: Toastie.lengthLong,
                                );
                              },
                              startIcon: Icon(
                                Icons.menu,
                                color: Palette.textColor,
                              ),
                              endIcon: Icon(
                                Icons.arrow_forward,
                                color: Palette.textColor,
                              ),
                            ),
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
                                } else if (currentSortingMethod ==
                                    "Insertion Sort") {
                                  try {
                                    sort("INSERTION SORT");
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
                            SizedBox(width: screenWidth / 5),
                            Row(
                              children: [
                                AnimatedIconButton(
                                  duration: Duration(milliseconds: 500),
                                  padding: EdgeInsets.fromLTRB(0.5, 0, 0, 0),
                                  startIcon: Icon(
                                    Icons.cached,
                                    color: Palette.textColor,
                                  ),
                                  endIcon: Icon(
                                    Icons.autorenew,
                                    color: Palette.textColor,
                                  ),
                                  size: 30.0,
                                  onPressed: () {
                                    if (isSelected) {
                                      _shuffle();
                                    } else {
                                      showToast(
                                        "$currentSortingMethod In Process.",
                                        gravity: Toastie.bottom,
                                        duration: Toastie.lengthLong,
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  iconSize: 30.0,
                                  color: Palette.textColor,
                                  onPressed: () {
                                    if (isSelected) {
                                      showSettingsPage();
                                    } else {
                                      showToast(
                                        "$currentSortingMethod In Process.",
                                        gravity: Toastie.bottom,
                                        duration: Toastie.lengthLong,
                                      );
                                    }
                                  },
                                ),
                              ],
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
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
 */
