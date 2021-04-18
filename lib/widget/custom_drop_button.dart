import 'package:flutter/material.dart';

Widget customDropButton({
  String value,
  Function onChanged,
  Widget icon,
  double iconSize,
  int elevation,
  List<DropdownMenuItem<String>> items,
  Function onTap,
}) {
  return DropdownButton<String>(
    dropdownColor: Colors.black,
    value: value,
    icon: icon,
    iconSize: iconSize,
    elevation: elevation,
    style: TextStyle(color: Colors.white),
    onChanged: onChanged,
    items: items,
    onTap: onTap,
  );
}
