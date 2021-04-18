import 'package:flutter/material.dart';

Widget customTextField({
  TextEditingController controller,
  String labelText,
  TextInputType textInputType,
  int maxLines,
  int minLines,
  String errorText,
  int maxLength,
  bool obscureText=false,
}) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        errorText: errorText,
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent[700])),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black, fontSize: 16),
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
    ),
  );
}
