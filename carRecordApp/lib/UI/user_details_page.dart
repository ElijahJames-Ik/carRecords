import 'package:carRecordApp/Templates/field_template.dart';
import 'package:carRecordApp/Templates/string_content_template.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewUserDetails extends StatelessWidget {
  static String routeName = "viewUserDetails";
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
          '${provider.userData.fullName}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: dimension.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(dimension.width * 0.15),
                      child: FadeInImage.assetNetwork(
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: 'assets/images/img_placeholder.png',
                        fit: BoxFit.cover,
                        image: provider.userData.avatar,
                        width: dimension.width * 0.3,
                        height: dimension.width * 0.3,
                      ),
                    ),
                    SizedBox(
                      width: dimension.width * 0.04,
                    ),
                    Text(
                      provider.userData.fullName,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.cyan[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: dimension.height * 0.04,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: FieldTemplate(
                  fieldName: 'Gender',
                  fieldData: '${provider.userData.gender}',
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: FieldTemplate(
                  fieldName: 'Date Created',
                  fieldData: '${provider.userData.createdAt}',
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: Text(
                  'Colors',
                  style: TextStyle(
                      color: Colors.cyan[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                height: dimension.height * 0.05,
                child: provider.userData.colorList.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.only(
                          left: dimension.width * 0.04,
                          right: dimension.width * 0.04,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.userData.colorList.length,
                        itemBuilder: (context, index) {
                          return StringContent(
                              content: provider.userData.colorList[index]);
                        })
                    : Container(
                        margin: EdgeInsets.only(
                          left: dimension.width * 0.04,
                          right: dimension.width * 0.04,
                        ),
                        child: Text('No colors',
                            style: TextStyle(
                                color: Colors.cyan[600], fontSize: 20)),
                      ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: Divider(
                  color: Colors.cyan[300],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: Text(
                  'Country',
                  style: TextStyle(
                      color: Colors.cyan[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                height: dimension.height * 0.05,
                child: provider.userData.countryList.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.only(
                          left: dimension.width * 0.04,
                          right: dimension.width * 0.04,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.userData.countryList.length,
                        itemBuilder: (context, index) {
                          return StringContent(
                              content: provider.userData.countryList[index]);
                        })
                    : Container(
                        margin: EdgeInsets.only(
                          left: dimension.width * 0.04,
                          right: dimension.width * 0.04,
                        ),
                        child: Text('No countries',
                            style: TextStyle(
                                color: Colors.cyan[600], fontSize: 20)),
                      ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: dimension.width * 0.04,
                  right: dimension.width * 0.04,
                ),
                child: Divider(
                  color: Colors.cyan[300],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
