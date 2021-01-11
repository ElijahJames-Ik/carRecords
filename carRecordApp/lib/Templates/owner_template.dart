import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:flutter/material.dart';

class OwnerTemplate extends StatelessWidget {
  final CarOwnerDataModel data;
  OwnerTemplate({this.data});

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Container(
      height: dimension.height * 0.25,
      child: Column(
        children: [
          Text(data.firstName),
          Text(data.carModel),
        ],
      ),
    );
  }
}
