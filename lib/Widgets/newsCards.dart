import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  String mainImage;
  var iconClub;
  String nameClub;
  String titleNews;
  String contentNews;

  NewsCard(
      {this.mainImage,
      this.iconClub,
      this.nameClub,
      this.titleNews,
      this.contentNews});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //  SizedBox(width: 20,),
        Flexible(
          flex: 3,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                mainImage,
                fit: BoxFit.fill,
                 height: MediaQuery.of(context).size.height * .15,
                 width: MediaQuery.of(context).size.width * .42,
              )),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ClipRRect(

                    child: Image.network(iconClub,
                        fit: BoxFit.fill, height: 30, width: 30), borderRadius: BorderRadius.circular(10),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    nameClub,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Text(
                titleNews,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Text(
                contentNews,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
    );
  }
}
