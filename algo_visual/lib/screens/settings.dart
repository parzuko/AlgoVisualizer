import 'package:algo_visual/config/palette.dart';
import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final double sizeOfArray;
  final double sortingSpeed;

  const SettingsDialog({Key key, this.sizeOfArray, this.sortingSpeed})
      : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  double _sizeOfArray;

  @override
  void initState() {
    super.initState();
    _sizeOfArray = widget.sizeOfArray;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "SETTINGS",
          style: TextStyle(
            color: Palette.brightText,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Segoe UI',
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
