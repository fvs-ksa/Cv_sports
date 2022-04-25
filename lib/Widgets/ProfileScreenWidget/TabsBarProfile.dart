import 'package:cv_sports/ProviderAll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ItemTapBarProfile.dart';
import 'package:easy_localization/easy_localization.dart';

class TabsBarProfile extends StatelessWidget {
  TabController tabController;


  TabsBarProfile({ @required this.tabController});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        child: TabBar(
          controller: tabController,
          labelPadding: EdgeInsets.all(0),
          labelColor: Colors.red,
          indicatorWeight: 0.1,
          unselectedLabelColor: Colors.black,
          isScrollable: true,

          onTap: (int i) {
            Provider.of<ProviderConstants>(context, listen: false)
                .ChangeIndexTap(Value: i);

            print("Index = " + i.toString());
          },

          tabs: [
            Tab(child: ItemTapBarProfile(title: "My data".tr(), indexItem: 0 ) ),
            Tab(child: ItemTapBarProfile(title: "My Posts".tr(), indexItem: 1)),
            Tab(child: ItemTapBarProfile(title: "Talks".tr(), indexItem: 2)),
          ],
        ),
      ),
    );
  }
}
