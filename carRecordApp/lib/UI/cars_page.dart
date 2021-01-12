import 'package:carRecordApp/Operations/operations_owners_page.dart';
import 'package:carRecordApp/Templates/owner_template.dart';
import 'package:carRecordApp/UI/filter_page_owners.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:carRecordApp/model/filter_data_model.dart';
import 'package:flutter/material.dart';

class Carspage extends StatefulWidget {
  static String routeName = 'cars_page';
  @override
  _CarspageState createState() => _CarspageState();
}

class _CarspageState extends State<Carspage> {
  String startMessage = "Loading data...";
  List<CarOwnerDataModel> data = new List<CarOwnerDataModel>();
  List<CarOwnerDataModel> dataOriginal = new List<CarOwnerDataModel>();
  bool isLoading = true;

  Future<void> openAndLoadFile() async {
    setState(() {
      isLoading = true;
    });
    OperationsOwnersPage.getCSVFile().then((file) {
      if (file != null) {
        setState(() {
          data = OperationsOwnersPage.decodeCSVFile(file);
          dataOriginal = data;
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openAndLoadFile().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
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
                  openAndLoadFile().then((_) {
                    setState(() {});
                  });
                }),
            IconButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, FilterPage.routeName)
                      .then((response) {
                    if (response != null) {
                      FilterModel filters = response as FilterModel;

                      setState(() {
                        data = OperationsOwnersPage.filterOwnersList(
                            dataOriginal, filters);
                      });
                    }
                  });
                })
          ],
        ),
        body: AbsorbPointer(
          absorbing: isLoading,
          child: data != null && data.length > 0
              ? Container(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return OwnerTemplate(data: data[index]);
                      }),
                )
              : Center(
                  child: data != null && isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.cyan[400]),
                        )
                      : Text('No Data'),
                ),
        ));
  }
}
