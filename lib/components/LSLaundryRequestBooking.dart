import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:urban_laundry_mobile/main.dart';
import 'package:urban_laundry_mobile/model/LSServiceModel.dart';
import 'package:urban_laundry_mobile/screens/LSForgotPasswordScreen.dart';
import 'package:urban_laundry_mobile/utils/LSColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../screens/LSOnBoardingScreen.dart';
import '../screens/LSOrderDetailScreen.dart';
import '../utils/LSImages.dart';
import '../utils/LSWidgets.dart';

class LSLaundryRequestComponents extends StatefulWidget {
  static String tag = '/LSLaundryRequestComponents';

  @override
  LSLaundryRequestComponentsState createState() => LSLaundryRequestComponentsState();
}

class LSLaundryRequestComponentsState extends State<LSLaundryRequestComponents> {
  bool isSignUp = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController mobNo = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController cPassCont = TextEditingController();

  Future register() async {
    var url = "http://192.168.1.12/urban_laundry/user/api/user_register.php";
    var response = await http.post(Uri.parse(url), body: {
      "fullname": fullName.text,
      "mobilenumber": mobNo.text,
      "email": emailCont.text,
      "password": passCont.text,
    });

    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LSOnBoardingScreen()),
      // );
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    afterBuildCreated(() {
      changeStatusColor(appStore.isDarkModeOn
          ? context.scaffoldBackgroundColor
          : LSColorSecondary);
    });
  }

  @override
  void dispose() {
    super.dispose();
    afterBuildCreated(() {
      changeStatusColor(Colors.transparent);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appStore.isDarkModeOn
          ? context.scaffoldBackgroundColor
          : LSColorSecondary.withOpacity(0.55),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.height,
                AppTextField(
                  controller: fullName,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'Pick up/Drop Date'),
                ),
                16.height,
                AppTextField(
                  controller: mobNo,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(
                      hintText: 'No. of Topwear(Tshirt,Top,Shirt)'),
                ),
                16.height,
                AppTextField(
                  controller: emailCont,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(
                      hintText: 'No. Bottomwear(Lower,Jeans,Leggins)'),
                ),
                16.height,
                AppTextField(
                  controller: passCont,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'No. Woolen Cloth'),
                ),
                16.height,
                AppTextField(
                  controller: cPassCont,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'Other'),
                ),
                16.height,
                AppTextField(
                  controller: mobNo,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'Service type'),
                ),
                16.height,
                AppTextField(
                  controller: mobNo,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'Pickup Address'),
                ),
                16.height,
                AppTextField(
                  controller: mobNo,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'Contact Person'),
                ),
                16.height,
                AppTextField(
                  controller: mobNo,
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(hintText: 'Description (if any)'),
                ),
              ],
            ),
            16.height,
            Container(
                height: 50,
                width: 180,
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: LSColorPrimary,
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Proceed for Payment',
                    style: TextStyle(color: Colors.white),
                  ),
                )).onTap(() {
              if (!isSignUp) {
                //sigin navigation
                //login();
                //LSOnBoardingScreen().launch(context);
              }
            }),
            24.height.visible(!isSignUp),
          ],
        ),
      ),
    );
  }
}
