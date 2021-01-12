import 'package:carRecordApp/UI/view_single_car_details.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnerTemplate extends StatelessWidget {
  final CarOwnerDataModel data;
  OwnerTemplate({this.data});

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    AppProvider provider = Provider.of<AppProvider>(context);
    return InkWell(
      onTap: () {
        provider.ownerData = data;
        Navigator.pushNamed(context, ViewCarOwnerDetails.routeName);
      },
      child: Container(
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
                Container(
                  width: dimension.width * 0.48,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.firstName} ${data.lastName}',
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '${data.jobTitle} ',
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[200],
                        ),
                      ),
                      Text(
                        '${data.carModel} ${data.carModelYear}',
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${data.country}',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  data.gender.toLowerCase() == 'male'
                      ? 'assets/images/male.png'
                      : 'assets/images/female.png',
                  width: dimension.width * 0.30,
                  height: dimension.height * 0.15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
