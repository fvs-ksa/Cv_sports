import 'package:cv_sports/Model/RolesSportِApiِِ.dart';
import 'package:cv_sports/Pages/Category/OneCategory.dart';
import 'package:cv_sports/Providers/RolesSportProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RowListSport extends StatefulWidget {

  @override
  _RowListSportState createState() => _RowListSportState();
}

class _RowListSportState extends State<RowListSport> {



  @override
  void initState() {
    Provider.of<RolesSportProvider>(context, listen: false)
        .getRolesSportData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<RolesSport> data = Provider.of<RolesSportProvider>(context).listRolesSport;

    return
      Provider.of<RolesSportProvider>(context).loading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)):
      Container(
      width: double.infinity,
            //     margin: EdgeInsets.only(top: 2),
            height: MediaQuery.of(context).size.height * .145,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return OneCategory(
                          indexRole: data[index].profileType.index,
                    itemSport: data[index],
                  );
                }));
              },
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 2),
                child: Column(
                  children: [
                    Container(
                      //   alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      width:  MediaQuery.of(context).size.width * .18,
                      height:  MediaQuery.of(context).size.height * .09,
                      child: ClipOval(
                        child: Material(
                          color: Color(0xff2C2B53), // button color
                          child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: Center(
                                child: Image.network(
                                  data[index].icon,
                                  // scale: 3,
                                  height:
                                  MediaQuery.of(context).size.height * .05,

                                  //    size: 25,
                                ),
                              )),
                        ),
                      ),
                    ),
                    Text(
                      data[index].name,
                            style: TextStyle(
                          //      fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w600),
                          )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
