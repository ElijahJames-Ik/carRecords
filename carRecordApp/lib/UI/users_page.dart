import 'package:carRecordApp/Operations/operations_users_page.dart';
import 'package:carRecordApp/Operations/shared_operations.dart';
import 'package:carRecordApp/Templates/user_template.dart';
import 'package:carRecordApp/UI/filter_page_users.dart';
import 'package:carRecordApp/model/filter_data_user_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  static String routeName = 'usersPage';
  bool isStarting = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    if (isStarting) {
      if (provider.userDataList == null) {
        UserOperations.getUserDataFromAPI(_scaffoldKey).then((response) {
          if (response != null) {
            provider.userDataList = response;
            provider.userDataListCopy = response;
            provider.isLoadingUserPage = false;
          } else {
            provider.isLoadingUserPage = false;
          }
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          provider.isLoadingUserPage = false;
        });
      }

      isStarting = false;
    }
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              if (!provider.isLoadingUserPage) {
                provider.filterUserModel = null;
                Navigator.pop(context);
              }
            }),
        title: Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.filter_list_alt, color: Colors.white),
              onPressed: () {
                if (!provider.isLoadingUserPage) {
                  if (provider.userDataListCopy != null &&
                      provider.userDataListCopy.length > 0) {
                    Navigator.pushNamed(context, FilterPageUsers.routeName)
                        .then((response) {
                      if (response != null) {
                        var filters = response as FilterUserModel;
                        var filteredList = UserOperations.filterUsersList(
                            provider.userDataListCopy, filters);

                        if (filteredList == null || filteredList.length == 0) {
                          SharedOperations.showMessage(
                              _scaffoldKey, 'filtered list has no data');
                        }
                        provider.userDataList = filteredList;
                      }
                    });
                  } else {
                    SharedOperations.showMessage(
                        _scaffoldKey, 'Can filter empty list');
                  }
                }
              })
        ],
      ),
      body: Builder(
        builder: (context) => Container(
            margin: EdgeInsets.only(
              left: dimension.width * 0.04,
              right: dimension.width * 0.04,
            ),
            child: provider.isLoadingUserPage
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.cyan[300]),
                    ),
                  )
                : provider.userDataList != null &&
                        provider.userDataList.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.only(top: dimension.height * 0.02),
                        itemCount: provider.userDataList.length,
                        itemBuilder: (context, index) {
                          return UserTemplate(
                            data: provider.userDataList[index],
                          );
                        })
                    : Center(
                        child: Text('No Data'),
                      )),
      ),
    );
  }
}
