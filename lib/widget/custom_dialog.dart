import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  String text1;
  String text2;
  String title;
  Function onTap;
  Function onTap1;
  CustomDialog({this.title, this.text1, this.text2, this.onTap, this.onTap1});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 30 / 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.6,
                  offset: Offset(0.7, 0.7))
            ],
            color: Colors.white),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold))),
            Divider(
              color: Colors.black12,
              height: 1.0,
              thickness: 2.0,
            ),
            SizedBox(
              height: 25.0,
            ),
            GestureDetector(
                onTap: onTap,
                child: Text(text1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))),
            SizedBox(
              height: 13.0,
            ),
            GestureDetector(
                onTap: onTap1,
                child: Text(text2,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 16.0,
                              spreadRadius: 0.6,
                              offset: Offset(0.7, 0.7))
                        ],
                        color: Colors.redAccent[700]),
                    height: MediaQuery.of(context).size.height * 5 / 100,
                    width: MediaQuery.of(context).size.width * 25 / 100,
                    child: Center(
                      child: Text("Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                    )))
          ],
        ),
      ),
    );
  }
}
