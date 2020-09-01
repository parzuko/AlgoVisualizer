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
    return AlertDialog();
}