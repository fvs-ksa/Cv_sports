import 'package:cv_sports/Model/usersApi.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CardInformation extends StatelessWidget {
  Users informationProfile;

  CardInformation({@required this.informationProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)),
      child: Card(
        margin: EdgeInsets.only(top: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: (informationProfile.playerDetails == null) &&
                  (informationProfile.extraDetails == null) &&
                  (informationProfile.clubDetails == null)
              ? Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    RowInformation(
                        context: context,
                        title: "date of Birth".tr(),
                        content: informationProfile.birthdate == null
                            ? "undefined".tr()
                            : DateFormat('yyyy-MM-dd')
                                .format(informationProfile.birthdate),
                        iconTitle: Icons.calendar_today),
                    RowInformation(
                        title: "Country".tr(),
                        context: context,
                        content: informationProfile.country == null
                            ? "undefined".tr()
                            : informationProfile.country.name,
                        iconTitle: Icons.map),
                    RowInformation(
                        context: context,
                        title: "City".tr(),
                        content: informationProfile.city == null
                            ? "undefined".tr()
                            : informationProfile.city.name,
                        iconTitle: Icons.location_on_rounded),
                  ],
                )
              : Column(
                  children: [
                    informationProfile.role.profileType.index == 2
                        ? ColumnPlayer(context: context)
                        : Container(),
                    informationProfile.role.profileType.index == 1
                        ? ColumnClub(context: context)
                        : Container(),
                    informationProfile.role.profileType.index == 0
                        ? ColumnExtra(context: context)
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }

//================= Column  Player ================
  Column ColumnPlayer({@required BuildContext context}) {
    return Column(
      children: [
        Container(
          height: 10,
        ),
        RowInformation(
            context: context,
            title: "date of Birth".tr(),
            content: informationProfile.birthdate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd').format(informationProfile.birthdate),
            iconTitle: Icons.calendar_today),
        RowInformation(
            context: context,
            title: "Club / Academy".tr(),
            content: informationProfile.playerDetails.clubName == null
                ? "undefined".tr()
                : informationProfile.playerDetails.clubName,
            iconTitle: Icons.person),
        RowInformation(
            context: context,
            title: "Sex".tr(),
            content: informationProfile.gender == null
                ? "undefined".tr()
                : informationProfile.gender.index == 0
                    ? "male".tr()
                    : "female".tr(),
            iconTitle: Icons.person_pin),
        RowInformation(
            context: context,
            title: "the game".tr(),
            content: informationProfile.sport.name == null
                ? "undefined".tr()
                : informationProfile.sport.name,
            iconTitle: Icons.gamepad),
        RowInformation(
            context: context,
            title: "Nationality".tr(),
            content: informationProfile.playerDetails.nationality.name == null
                ? "undefined".tr()
                : informationProfile.playerDetails.nationality.name,
            iconTitle: Icons.flag),
        RowInformation(
            context: context,
            title: "Country".tr(),
            content: informationProfile.country == null
                ? "undefined".tr()
                : informationProfile.country.name,
            iconTitle: Icons.map),
        RowInformation(
            context: context,
            title: "City".tr(),
            content: informationProfile.city == null
                ? "undefined".tr()
                : informationProfile.city.name,
            iconTitle: Icons.location_on_rounded),
        RowInformation(
            context: context,
            title: "Length".tr(),
            content: informationProfile.playerDetails.height == null
                ? "undefined".tr()
                : informationProfile.playerDetails.height.toString(),
            iconTitle: Icons.height),
        RowInformation(
            context: context,
            title: "weight".tr(),
            content: informationProfile.playerDetails.weight == null
                ? "undefined".tr()
                : informationProfile.playerDetails.weight.toString() +
                    "  " +
                    (informationProfile.playerDetails.weightUnit.index == 0
                        ? "KG"
                        : "Pound"),
            iconTitle: Icons.anchor),
        RowInformation(
            context: context,
            title: "Beginning of the contract".tr(),
            content: informationProfile.playerDetails.contractStartDate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd')
                    .format(informationProfile.playerDetails.contractStartDate),
            iconTitle: Icons.calendar_today),
        RowInformation(
            context: context,
            title: "End of the contract".tr(),
            content: informationProfile.playerDetails.contractEndDate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd')
                    .format(informationProfile.playerDetails.contractEndDate),
            iconTitle: Icons.calendar_today),
        RowInformation(
            context: context,
            title: "Play the game".tr(),
            content: informationProfile.playerDetails.playerStyle == null
                ? "undefined".tr()
                : informationProfile.playerDetails.playerStyle,
            iconTitle: Icons.sports),
        RowInformation(
            context: context,
            title: "Player Center".tr(),
            content: informationProfile.playerDetails.playerRole == null
                ? "undefined".tr()
                : informationProfile.playerDetails.playerRole,
            iconTitle: Icons.sports_volleyball),
        RowInformation(
            context: context,
            title: "CV".tr(),
            content: informationProfile.playerDetails.cv == null
                ? "undefined".tr()
                : informationProfile.playerDetails.cv,
            iconTitle: Icons.textsms_sharp),
        Container(
          height: 10,
        ),
      ],
    );
  }
//================= Column  Club ================

  Column ColumnClub({@required BuildContext context}) {
    return Column(
      children: [
        Container(
          height: 10,
        ),
        RowInformation(
            context: context,
            title: "Foundational History".tr(),
            content: informationProfile.clubDetails.creationDate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd')
                    .format(informationProfile.clubDetails.creationDate),
            iconTitle: Icons.calendar_today),
        RowInformation(
            context: context,
            title: "Club / Academy".tr(),
            content: informationProfile.clubDetails.name == null
                ? "undefined".tr()
                : informationProfile.clubDetails.name,
            iconTitle: Icons.person),
        RowInformation(
            context: context,
            title: "City".tr(),
            content: informationProfile.clubDetails.place == null
                ? "undefined".tr()
                : informationProfile.clubDetails.place,
            iconTitle: Icons.location_on_rounded),
        Container(
          height: 10,
        )
      ],
    );
  }
//================= Column  Extra ================

  Column ColumnExtra({@required BuildContext context}) {
    return Column(
      children: [
        Container(
          height: 10,
        ),
        RowInformation(
            context: context,
            title: "date of Birth".tr(),
            content: informationProfile.birthdate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd').format(informationProfile.birthdate),
            iconTitle: Icons.calendar_today),
        // RowInformation(
        //     context: context,
        //     title: "Club / Academy".tr(),
        //     content: informationProfile.name == null
        //         ? "undefined".tr()
        //         : informationProfile.name,
        //     iconTitle: Icons.person),
        RowInformation(
            context: context,
            title: "Workplace".tr(),
            content: informationProfile.extraDetails.workPlace == null
                ? "undefined".tr()
                : informationProfile.extraDetails.workPlace,
            iconTitle: Icons.location_on_rounded),
        RowInformation(
            context: context,
            title: "Qualification".tr(),
            content: informationProfile.extraDetails.qualification == null
                ? "undefined".tr()
                : informationProfile.extraDetails.qualification,
            iconTitle: Icons.equalizer),
        RowInformation(
            context: context,
            title: "Nationality".tr(),
            content: informationProfile.extraDetails.nationality.name == null
                ? "undefined".tr()
                : informationProfile.extraDetails.nationality.name,
            iconTitle: Icons.flag),
        RowInformation(
            context: context,
            title: "Beginning of the contract".tr(),
            content: informationProfile.extraDetails.contractStartDate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd')
                    .format(informationProfile.extraDetails.contractStartDate),
            iconTitle: Icons.calendar_today),
        RowInformation(
            context: context,
            title: "End of the contract".tr(),
            content: informationProfile.extraDetails.contractEndDate == null
                ? "undefined".tr()
                : DateFormat('yyyy-MM-dd')
                    .format(informationProfile.extraDetails.contractEndDate),
            iconTitle: Icons.calendar_today),
        RowInformation(
            context: context,
            title: "CV".tr(),
            content: informationProfile.extraDetails.cv == null
                ? "undefined".tr()
                : informationProfile.extraDetails.cv,
            iconTitle: Icons.textsms_sharp),
        Container(
          height: 10,
        )
      ],
    );
  }

//================= Row Information ================

  Column RowInformation(
      {String title,
      var iconTitle,
      String content,
      @required BuildContext context}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    iconTitle,
                    color: Color(0xff68699C),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Text(title,
                        style: TextStyle(
                    //        fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * .35,
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                 //     fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2C2B53)),
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 10,
          color: Colors.grey,
        )
      ],
    );
  }
}
