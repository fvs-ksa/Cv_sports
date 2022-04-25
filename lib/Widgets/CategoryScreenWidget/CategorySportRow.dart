import 'package:cv_sports/Model/SportApi.dart';
import 'package:cv_sports/Providers/CategoryProvider.dart';
import 'package:cv_sports/Providers/RolesSportProvider.dart';
import 'package:cv_sports/Widgets/Globle/NoFoundResultApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySportRow extends StatefulWidget {
  @override
  _CategorySportRowState createState() => _CategorySportRowState();
}

class _CategorySportRowState extends State<CategorySportRow> {
  int checkTap;

  @override
  void initState() {
    if (Provider.of<CategoryProvider>(context, listen: false)
            .listCategory
            .length ==
        0) {
      Provider.of<CategoryProvider>(context, listen: false).getCategoriesData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<SportApi> data = Provider.of<CategoryProvider>(context).listCategory;
    return Provider.of<CategoryProvider>(context).loading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
        : Container(
            alignment: Alignment.center,
            height: .12 * MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        checkTap = index;
                      });

                      Provider.of<RolesSportProvider>(context, listen: false)
                          .setSportIdAndUpdateRolesSportData(
                              setSportId: data[index].id,
                              setNameCategorySport: data[index].name);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              data[index].icon,
                              height: MediaQuery.of(context).size.height * .067,
                              width: MediaQuery.of(context).size.width * .125,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            data[index].name,
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  checkTap == index ? Colors.red : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
