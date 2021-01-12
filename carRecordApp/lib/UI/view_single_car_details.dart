import 'package:carRecordApp/Templates/field_template.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCarOwnerDetails extends StatelessWidget {
  static String routeName = "viewCarDetails";
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          '${provider.ownerData.firstName} ${provider.ownerData.lastName}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: dimension.width * 0.04,
            top: dimension.height * 0.04,
            right: dimension.width * 0.04,
          ),
          child: Column(
            children: [
              FieldTemplate(
                fieldName: 'Id',
                fieldData: '${provider.ownerData.id}',
              ),
              FieldTemplate(
                fieldName: 'First Name',
                fieldData: '${provider.ownerData.firstName}',
              ),
              FieldTemplate(
                fieldName: 'Last Name',
                fieldData: '${provider.ownerData.lastName}',
              ),
              FieldTemplate(
                fieldName: 'Email',
                fieldData: '${provider.ownerData.email}',
              ),
              FieldTemplate(
                fieldName: 'Country',
                fieldData: '${provider.ownerData.country}',
              ),
              FieldTemplate(
                fieldName: 'Car Model',
                fieldData: '${provider.ownerData.carModel}',
              ),
              FieldTemplate(
                fieldName: 'Car model year',
                fieldData: '${provider.ownerData.carModelYear}',
              ),
              FieldTemplate(
                fieldName: 'Car Color',
                fieldData: '${provider.ownerData.carColor}',
              ),
              FieldTemplate(
                fieldName: 'Gender',
                fieldData: '${provider.ownerData.gender}',
              ),
              FieldTemplate(
                fieldName: 'Job Title',
                fieldData: '${provider.ownerData.jobTitle}',
              ),
              FieldTemplate(
                fieldName: 'Bio',
                fieldData: '${provider.ownerData.bio}',
              ),
              SizedBox(
                height: dimension.height * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }
}
