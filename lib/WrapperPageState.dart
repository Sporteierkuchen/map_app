
import 'package:flutter/material.dart';

abstract class WrapperPageState<T extends StatefulWidget> extends State<T> {
  Widget getContent();

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Expanded(
          child:
              Container(padding: const EdgeInsets.all(10), child: getContent()))
    ])));
  }
}
