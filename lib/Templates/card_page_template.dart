import 'package:flutter/material.dart';

class Holder extends StatelessWidget {
  final String cardName;
  final Function nextPageAction;
  final IconData icon;
  Holder({this.cardName, this.nextPageAction, this.icon});
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return GestureDetector(
      key: Key(cardName),
      onTap: nextPageAction,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimension.width * 0.04),
            border: Border.all(color: Colors.cyan[300], width: 1)),
        height: dimension.height * 0.08,
        width: double.infinity,
        margin: EdgeInsets.only(
          left: dimension.width * 0.04,
          right: dimension.width * 0.04,
          top: dimension.height * 0.04,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: dimension.width * 0.02,
            ),
            Icon(
              icon,
              color: Colors.cyan[600],
              size: 30,
            ),
            SizedBox(
              width: dimension.width * 0.02,
            ),
            Text(
              cardName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.cyan[600]),
            )
          ],
        ),
      ),
    );
  }
}
