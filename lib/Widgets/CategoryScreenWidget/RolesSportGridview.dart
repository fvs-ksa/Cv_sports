import 'package:cv_sports/Model/RolesSportِApiِِ.dart';
import 'package:cv_sports/Pages/Category/OneCategory.dart';
import 'package:cv_sports/Providers/RolesSportProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class RolesSportGridView extends StatefulWidget {
  @override
  _RolesSportGridViewState createState() => _RolesSportGridViewState();
}

class _RolesSportGridViewState extends State<RolesSportGridView> {
  @override
  void initState() {
    Provider.of<RolesSportProvider>(context, listen: false).getRolesSportData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<RolesSport> data =
        Provider.of<RolesSportProvider>(context).listRolesSport;
    return Provider.of<RolesSportProvider>(context).loading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
        : Expanded(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: GridView.builder(
                shrinkWrap: true,

                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),

                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (Provider.of<RolesSportProvider>(context,
                                  listen: false)
                              .sportId ==
                          null) {
                        showExitDialog(context);
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OneCategory(
                            titleCategorySport: Provider.of<RolesSportProvider>(
                                    context,
                                    listen: false)
                                .nameCategorySport,
                            idCategorySport: Provider.of<RolesSportProvider>(
                                    context,
                                    listen: false)
                                .sportId,
                            indexRole: data[index].profileType.index,
                            itemSport: data[index],
                          );
                        }));
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0, color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          child: columnMoreData(
                              context: context, SportData: data[index])),
                    ),
                  );
                },
              ),
            ),
          );
  }

  //=============================== column More Data ==============================
  SingleChildScrollView columnMoreData(
      {RolesSport SportData, BuildContext context}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // padding: EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width * .17,
            height: MediaQuery.of(context).size.height * .07,
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: Center(
                child: Image.network(
                  SportData.icon,
                  fit: BoxFit.fill,

                  //scale:6,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            SportData.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Text(
          //   SportData.userCount.toString(),
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
        ],
      ),
    );
  }
  //=============================== showExitAuthDialog ==============================

  showExitDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: new Text(
                "You cannot access the details.".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Text(
                    "You must choose a game first.".tr(),
                    style: TextStyle(color: Color(0xff8E93A2), fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      margin: const EdgeInsets.only(right: 2, left: 2),
                      decoration: BoxDecoration(
                          color: Color(0xff222B45),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white)),
                      width: MediaQuery.of(context).size.width * 0.28,
                      alignment: Alignment.center,
                      child: Text(
                        "OK".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
