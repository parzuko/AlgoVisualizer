import 'package:algo_visual/config/list_view_info.dart';
import 'package:algo_visual/config/palette.dart';
import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final double sizeOfArray;
  final int currentTheme;
  final List<bool> theThemes;

  const SettingsDialog(
      {Key key, this.sizeOfArray, this.currentTheme, this.theThemes})
      : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  double _sizeOfArray;
  int currentTheme;
  List<bool> theThemes;

  @override
  void initState() {
    super.initState();
    _sizeOfArray = widget.sizeOfArray;
    currentTheme = widget.currentTheme;
    theThemes = widget.theThemes;
  }

  List<ColorList> colorOptions = [
    ColorList(colorName: "Arctic Horizon", imageLocation: "arcticblue.jpg"),
    ColorList(colorName: "Summer Hues", imageLocation: "sh.jpg"),
    ColorList(colorName: "Kindergarten Notebook", imageLocation: "pastel.jpg"),
    ColorList(colorName: "Ketchup Red", imageLocation: "ketchup.jpg"),
    ColorList(colorName: "Ice Cream Sandwhich", imageLocation: "ic.jpg"),
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
      title: Center(
        child: Text(
          'SETTINGS',
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
                      setState(() {
                        for (var each = 0; each < theThemes.length; each++) {
                          theThemes[each] = false;
                        }
                      });
                      setState(() => theThemes[index] = !theThemes[index]);
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/${colorOptions[index].imageLocation}"),
                    ),
                    title: Text(
                      colorOptions[index].colorName,
                      style: TextStyle(
                        color: theThemes[index]
                            ? Palette.theButton
                            : Palette.scaffold,
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
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print(theThemes);
            Navigator.pop(context, [_sizeOfArray, currentTheme, theThemes]);
          },
          child: Text(
            'DONE',
            style: TextStyle(
              color: Palette.brightText,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Segoe UI',
              letterSpacing: 0.8,
            ),
          ),
        )
      ],
    );
  }
}
