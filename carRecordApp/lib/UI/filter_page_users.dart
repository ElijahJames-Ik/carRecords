import 'package:carRecordApp/Templates/string_content_template.dart';
import 'package:carRecordApp/model/filter_data_user_model.dart';
import 'package:flutter/material.dart';

class FilterPageUsers extends StatefulWidget {
  static String routeName = '/filterUsers';
  @override
  _FilterPageUsersState createState() => _FilterPageUsersState();
}

class _FilterPageUsersState extends State<FilterPageUsers> {
  GlobalKey<ScaffoldState> _scaffoldKey3 = new GlobalKey<ScaffoldState>();
  TextEditingController country = new TextEditingController();
  TextEditingController color = new TextEditingController();
  List<String> countryList = new List<String>();
  List<String> colorList = new List<String>();
  List<DropdownMenuItem> genderList = [
    DropdownMenuItem(
      child: Text('All'),
      value: 'All',
    ),
    DropdownMenuItem(
      child: Text('Male'),
      value: 'Male',
    ),
    DropdownMenuItem(child: Text('Female'), value: 'Female')
  ];
  String gender;

  Future<Null> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: DateTime(2015, 1),
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2015, 12));
    if (picked != null) {
      setState(() {
        controller.text = picked.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey3,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Filter Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan[400],
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: dimension.width * 0.05,
                top: dimension.height * 0.05,
                right: dimension.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: dimension.height * 0.04,
                ),
                Text(
                  'Gender',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.cyan),
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.cyan),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                    hint: Text('Select gender'),
                    items: genderList,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    }),
                SizedBox(
                  height: dimension.height * 0.04,
                ),
                Text(
                  'Countries',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.cyan),
                ),
                TextField(
                  onSubmitted: (value) {
                    setState(() {
                      countryList.add(value);
                      country.clear();
                    });
                  },
                  controller: country,
                  decoration: InputDecoration(
                    hintText: 'Enter Country',
                    border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.cyan),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                ),
                SizedBox(
                  height: dimension.height * 0.02,
                ),
                countryList.length > 0
                    ? Container(
                        height: dimension.height * 0.04,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: countryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      countryList.remove(countryList[index]);
                                    });
                                  },
                                  child: StringContent(
                                      content: countryList[index]));
                            }),
                      )
                    : SizedBox(),
                SizedBox(
                  height: dimension.height * 0.04,
                ),
                Text(
                  'Color',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.cyan),
                ),
                TextField(
                  onSubmitted: (value) {
                    setState(() {
                      colorList.add(value);
                      color.clear();
                    });
                  },
                  controller: color,
                  decoration: InputDecoration(
                    hintText: 'Enter Color',
                    border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.cyan),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                ),
                SizedBox(
                  height: dimension.height * 0.02,
                ),
                colorList.length > 0
                    ? Container(
                        height: dimension.height * 0.04,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: colorList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      colorList.remove(colorList[index]);
                                    });
                                  },
                                  child:
                                      StringContent(content: colorList[index]));
                            }),
                      )
                    : SizedBox(),
                SizedBox(
                  height: dimension.height * 0.02,
                ),
                FlatButton(
                    color: Colors.cyan[400],
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(dimension.width * 0.04)),
                    onPressed: () {
                      FilterModelUser filterData = new FilterModelUser(
                        colors: colorList,
                        countries: countryList,
                        gender: gender,
                      );
                      Navigator.pop(context, filterData);
                    },
                    child: Text(
                      'Apply Filter',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
