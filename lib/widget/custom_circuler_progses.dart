import 'package:flutter/material.dart';

class CustomCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Opacity(opacity: 0.60,child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(backgroundColor: Colors.redAccent[700],strokeWidth: 4.0,),
              SizedBox(height: 3.0,),
              Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 20.0),),
            ],
          ),
        )),
      ),
    );
  }
}
