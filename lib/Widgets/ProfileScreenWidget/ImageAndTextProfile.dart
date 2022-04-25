import 'package:flutter/material.dart';

class ImageAndTextProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(


            height: .094*
                MediaQuery.of(context).size.height,
            width: .17*
                MediaQuery.of(context).size.width,
            child: CircleAvatar(
                backgroundColor: Colors.transparent,

                backgroundImage: AssetImage("assets/images/imageprofile.png")),
          ),
          Text(
            "خالد عمر",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "مهاجم",
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
