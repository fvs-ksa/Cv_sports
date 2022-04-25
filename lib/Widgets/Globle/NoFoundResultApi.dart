import 'package:flutter/material.dart';

class NoFoundResultApi extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Text(
            "لا يوجد حاليا",
            maxLines: null,
            softWrap: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "Amiri",
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}