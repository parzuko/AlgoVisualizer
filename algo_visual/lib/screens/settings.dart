import 'package:algo_visual/config/palette.dart';
import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final double sizeOfArray;
  final int currentTheme;

  const SettingsDialog({Key key, this.sizeOfArray, this.currentTheme})
      : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  double _sizeOfArray;
  int currentTheme;

  @override
  void initState() {
    super.initState();
    _sizeOfArray = widget.sizeOfArray;
    currentTheme = widget.currentTheme;
  }

  List<String> colorOptions = [
    "Arctic Horizon",
    "Summer Hues",
    "Kindergarten Notebook",
    "Ketchup Red",
    "Ice Cream SandWhich"
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      titleTextStyle: TextStyle(
        color: Palette.brightText,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Segoe UI',
        letterSpacing: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      content: Column(
        children: [
          Text(
            "Press 'Done' to confirm changes.",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Segoe UI",
              fontSize: 12.0,
            ),
          ),
          Divider(
            height: 6.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Array Length",
            style: TextStyle(
              color: Palette.scaffold,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Segoe UI',
              letterSpacing: 1,
            ),
          ),
          Slider(
            value: _sizeOfArray,
            min: 100,
            max: 500,
            divisions: 4,
            inactiveColor: Palette.scaffold,
            activeColor: Palette.theButton,
            label: "Set Size Of Array To: ${_sizeOfArray.round()}",
            onChanged: (value) {
              setState(() {
                _sizeOfArray = value;
              });
            },
          ),
          Divider(
            height: 8.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'COLORS',
            style: TextStyle(
              color: Palette.brightText,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Segoe UI',
              letterSpacing: 1.0,
            ),
          ),
          Container(
            height: screenHeight / 4,
            width: screenWidth,
            child: ListView.builder(
              itemCount: colorOptions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentTheme = index + 1;
                      });
                      //mode = index;
                      print("this is index & mode $index");
                      // print("this is index & mode $mode");
                    },
                    title: Text(
                      colorOptions[index],
                      style: TextStyle(
                        color: Palette.scaffold,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Segoe UI',
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
