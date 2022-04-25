import 'package:cv_sports/Widgets/CategoryScreenWidget/CategorySportRow.dart';
import 'package:cv_sports/Widgets/CategoryScreenWidget/RolesSportGridview.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffF9FAFF),
        child: Column(
          children: [
            CategorySportRow(),
            RolesSportGridView(),
            // SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      ),
    );
  }
}
