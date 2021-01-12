import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:flutter/material.dart';

class OwnerTemplate extends StatelessWidget {
  final CarOwnerDataModel data;
  OwnerTemplate({this.data});

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(dimension.width * 0.04),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dimension.width * 0.03)),
      height: dimension.height * 0.25,
      child: Card(
        color: Colors.cyan[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(dimension.width * 0.05),
          ),
        ),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.only(
            left: dimension.width * 0.05,
            top: dimension.height * 0.04,
            right: dimension.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.firstName} ${data.lastName}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    '${data.jobTitle} ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${data.carModel} ${data.carModelYear}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${data.country}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
