import 'package:cv_sports/ProviderAll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemTapBarProfile extends StatelessWidget {


  Color backgroundColor;
  Color textColor;
  String title;
  int indexItem;


  ItemTapBarProfile({ this.title, this.indexItem });

  @override
  Widget build(BuildContext context) {
    backgroundColor =
    indexItem == Provider.of<ProviderConstants>(context).IndexTap
        ? Color(0xff2C2B53)
        : Colors.white;
    textColor = indexItem == Provider.of<ProviderConstants>(context).IndexTap
        ? Colors.white
        : Colors.black;
    return
      Container(
        padding: const EdgeInsets.only(bottom: 5),
        margin: const EdgeInsets.only(right: 2, left: 2),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        width: MediaQuery.of(context).size.width * 0.28,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 16),
        ),
      );
  }
}
