import 'package:carRecordApp/UI/user_details_page.dart';
import 'package:carRecordApp/UI/view_single_car_details.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/model/user_data_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTemplate extends StatelessWidget {
  final UserDataModel data;
  UserTemplate({this.data});

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    AppProvider provider = Provider.of<AppProvider>(context);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(dimension.width * 0.01),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimension.width * 0.04),
              border: Border.all(color: Colors.cyan[300], width: 1)),
          child: ListTile(
            onTap: () {
              provider.userData = data;
              Navigator.pushNamed(context, ViewUserDetails.routeName);
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(dimension.width * 0.07),
              child: FadeInImage.assetNetwork(
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: 'assets/images/img_placeholder.png',
                fit: BoxFit.cover,
                image: data.avatar,
                width: dimension.width * 0.14,
                height: dimension.width * 0.14,
              ),
            ),
            title: Text(
              '${data.fullName}',
              overflow: TextOverflow.fade,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[600]),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.cyan[600],
            ),
          ),
        ),
        SizedBox(
          height: dimension.width * 0.02,
        )
      ],
    );
  }
}
