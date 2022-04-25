import 'package:bot_toast/bot_toast.dart';
import 'package:cv_sports/Pages/home/MainScreen.dart';
import 'package:cv_sports/Services/AllServices/SettingsServices/ServiceContactUs.dart';
import 'package:cv_sports/Widgets/Globle/BottomApp.dart';
import 'package:cv_sports/Widgets/Globle/InputFieldMake.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PageContactUs extends StatefulWidget {
  @override
  _PageContactUsState createState() => _PageContactUsState();
}

class _PageContactUsState extends State<PageContactUs> {
  TextEditingController controllerName = TextEditingController();

  FocusNode focusName = new FocusNode();
  TextEditingController controllerEmail = TextEditingController();

  FocusNode focusEmail = new FocusNode();
  TextEditingController textEditingController = TextEditingController();

  int maxLengthEnd = 255;

  int maxLengthStart = 255;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Connect with us".tr(),
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    InputFieldMake(
                      title: "The sender's name".tr(),
                      inputController: controllerName,
                      touchFocus: focusName,
                      iconInput: Icons.person,
                      validatorInput: (input) {
                        if (input.trim().length <= 0) {
                          return "Please put a name".tr();
                        } else if (input.trim().length < 5) {
                          return "The name must not be less than 5 letters"
                              .tr();
                        }
                        return null;
                      },
                    ),
                    InputFieldMake(
                      title: "Sender mail".tr(),
                      inputController: controllerEmail,
                      touchFocus: focusEmail,
                      iconInput: Icons.email,
                      validatorInput: (input) {
                        if (input.trim().length <= 0) {
                          return "Please put a name".tr();
                        } else if (input.trim().length < 8) {
                          return "The name must not be less than 8 characters."
                              .tr();
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .36,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        validator: (input) {
                          if (input.trim().length <= 0) {
                            return "Please put a message".tr();
                          } else if (input.trim().length < 8) {
                            return "The name must not be less than 8 characters."
                                .tr();
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        maxLines: null,
                        maxLength: maxLengthStart,
                        style: TextStyle(
                     //     fontSize: ScreenUtil().setSp(18),
                          height: 1.5,
                          color: Colors.black,
                        ),
                        controller: textEditingController,
                        onChanged: (value) {
                          setState(() {
                            maxLengthEnd = maxLengthStart - value.length;
                          });
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(
                              //  fontSize: ScreenUtil().setSp(18)
                                ),
                          hintText: "write here".tr(),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: Text(maxLengthEnd.toString(),
                          style: TextStyle(
                         //   fontSize: ScreenUtil().setSp(18)
                            )),
                    ),
                  ],
                ),
              ),
              BottomApp(
                title: "Update".tr(),
                setCircular: 10,
                functionButton: () async {
                  if (formKey.currentState.validate()) {
                    await ServiceContactUs()
                        .postAddContactUs(
                            name: controllerName.text.trim(),
                            email: controllerEmail.text.trim(),
                            message: textEditingController.text.trim())
                        .whenComplete(() {
                      BotToast.showText(
                        text: "Updated".tr(),
                        contentColor: Colors.blue,
                      );
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                    });
                  }
                },
                setWidth: .8,
                oneColor: Color(0xff2C2B53),
                twoColor: Color(0xff2C2B53),
                colorTitle: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
