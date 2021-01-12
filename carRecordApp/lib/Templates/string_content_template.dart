import 'dart:ui';

import 'package:flutter/material.dart';

class StringContent extends StatelessWidget {
  final String content;
  StringContent({this.content});
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Row(
      children: [
        Tooltip(
          message: 'Click to remove',
          child: Container(
            padding: EdgeInsets.all(dimension.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimension.width * 0.04),
              color: Colors.cyan[400],
            ),
            child: Text(
              content,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: dimension.width * 0.02,
        )
      ],
    );
  }
}
