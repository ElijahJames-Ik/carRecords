import 'package:carRecordApp/Templates/owner_template.dart';
import 'package:carRecordApp/model/car_owners_data_model.dart';
import 'package:flutter/material.dart';
import 'package:carRecordApp/Operations/operations.dart';

class Carspage extends StatefulWidget {
  @override
  _CarspageState createState() => _CarspageState();
}

class _CarspageState extends State<Carspage> {
  String startMessage = "Loading data...";
  List<CarOwnerDataModel> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Operations.getCSVFile().then((file) {
      if (file != null) {
        setState(() {
          data = Operations.decodeCSVFile(file);
        });
      } else {
        data = null;
        startMessage = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cars'),
        backgroundColor: Colors.red,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      body: data != null
          ? Container(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return OwnerTemplate(data: data[index]);
                  }),
            )
          : Center(
              child: Text('Loading...'),
            ),
    );
  }
}
