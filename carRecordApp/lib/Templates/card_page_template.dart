import 'package:flutter/material.dart';

class Holder extends StatelessWidget {
  final String cardName;
  final Function nextPageAction;
  Holder({this.cardName, this.nextPageAction});
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: nextPageAction,
      child: Column(
        children: [
          Card(
            color: Colors.cyan[400],
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(dimension.width * 0.04),
            // ),
            child: Container(
              height: dimension.height * 0.08,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: dimension.width * 0.04,
                right: dimension.width * 0.04,
                top: dimension.height * 0.04,
              ),
              child: Column(
                children: [
                  Text(
                    cardName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: dimension.height * 0.01,
          )
        ],
      ),
    );
  }
}
