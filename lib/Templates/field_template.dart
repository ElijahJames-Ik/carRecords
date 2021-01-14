import 'package:flutter/material.dart';

class FieldTemplate extends StatelessWidget {
  final String fieldName;
  final String fieldData;
  FieldTemplate({this.fieldName, this.fieldData});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: TextStyle(
                color: Colors.cyan[700],
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Text(fieldData,
              style: TextStyle(color: Colors.cyan[600], fontSize: 20)),
          Divider(
            color: Colors.cyan[300],
          )
        ],
      ),
    );
  }
}
