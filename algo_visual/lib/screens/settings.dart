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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
