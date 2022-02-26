
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({Key key}) : super(key: key);

  @override
  _loading_screenState createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
size: 100,
        ),
      ),
    );
  }
}
