import 'package:carRecordApp/Operations/operations_owners_page.dart';
import 'package:carRecordApp/Operations/shared_operations.dart';
import 'package:carRecordApp/Templates/owner_template.dart';
import 'package:carRecordApp/UI/filter_page_owners.dart';
import 'package:carRecordApp/model/filter_data_car_model.dart';
import 'package:carRecordApp/provider/app_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Carspage extends StatelessWidget {
  static String routeName = 'cars_page';
  GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();

  bool isStarting = true;
  bool isOpenPickedRequested = false;

  void defaultOpen(AppProvider provider) {
    OperationsOwnersPage.getCSVFile(_scaffoldKey2, provider).then((file) {
      if (file != null) {
        OperationsOwnersPage.decodeCSVFile(file, provider, _scaffoldKey2);
      } else {
        provider.isLoadingCarsPage = false;
      }
    });
  }

  Future<void> openAndLoadFile(AppProvider provider) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.isLoadingCarsPage = true;
    });
    SharedOperations.getFileLocation().then((response) {
      if (response != null && !isOpenPickedRequested) {
        File(response).exists().then((exists) {
          if (exists) {
            PlatformFile file = new PlatformFile(path: response);
            OperationsOwnersPage.decodeCSVFile(file, provider, _scaffoldKey2);
          } else {
            SharedOperations.showMessage(
                key, 'File doesn\'t exist, please select a new file');
            defaultOpen(provider);
          }
        });
      } else {
        defaultOpen(provider);
      }
      isOpenPickedRequested = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var dimension = MediaQuery.of(context).size;
    var provider = Provider.of<AppProvider>(context);
    if (isStarting) {
      if (provider.ownersDataListCopy != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          provider.ownersDataList = provider.ownersDataListCopy;
          provider.isLoadingCarsPage = false;
        });
      } else {
        openAndLoadFile(provider);
      }

      isStarting = false;
    }
    return Scaffold(
      key: _scaffoldKey2,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (!provider.isLoadingCarsPage) {
              provider.filterCarModel = null;
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Cars owners list',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan[400],
        actions: [
          IconButton(
              icon: Icon(Icons.file_upload, color: Colors.white),
              onPressed: () async {
                if (!provider.isLoadingCarsPage) {
                  isOpenPickedRequested = true;
                  openAndLoadFile(provider);
                }
              }),
          IconButton(
              icon: Icon(
                Icons.filter_list_alt,
                color: Colors.white,
              ),
              onPressed: () {
                if (provider.ownersDataList == null) {
                  SharedOperations.showMessage(
                      _scaffoldKey2, 'No data to filter');
                  return;
                }
                Navigator.pushNamed(context, FilterPage.routeName)
                    .then((response) {
                  if (response != null) {
                    FilterCarModel filters = response as FilterCarModel;

                    var filteredList = OperationsOwnersPage.filterOwnersList(
                        provider.ownersDataListCopy, filters);
                    if (filteredList == null || filteredList.length == 0) {
                      SharedOperations.showMessage(
                          _scaffoldKey2, 'filtered list has no data');
                    }
                    provider.ownersDataList = filteredList;
                  }
                });
              })
        ],
      ),
      body: Builder(
        builder: (context) => AbsorbPointer(
          absorbing: provider.isLoadingCarsPage,
          child: provider.ownersDataList != null &&
                  provider.ownersDataList.length > 0
              ? Container(
                  child: ListView.builder(
                      itemCount: provider.ownersDataList.length,
                      itemBuilder: (context, index) {
                        return OwnerTemplate(
                            data: provider.ownersDataList[index]);
                      }),
                )
              : Center(
                  child: provider.ownersDataList == null &&
                              provider.isLoadingCarsPage ||
                          provider.ownersDataList != null &&
                              provider.isLoadingCarsPage
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.cyan[400]),
                        )
                      : Text('No Data'),
                ),
        ),
      ),
    );
  }
}
