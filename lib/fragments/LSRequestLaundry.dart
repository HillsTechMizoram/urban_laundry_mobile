import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:urban_laundry_mobile/components/LSLaundryRequest.dart';
import 'package:urban_laundry_mobile/main.dart';
import 'package:urban_laundry_mobile/screens/LSForgotPasswordScreen.dart';
import 'package:urban_laundry_mobile/screens/LSOnBoardingScreen.dart';
import 'package:urban_laundry_mobile/utils/LSColors.dart';
import 'package:urban_laundry_mobile/utils/LSImages.dart';
import 'package:urban_laundry_mobile/utils/LSWidgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../components/LSBookingComponents.dart';
import '../components/LSLaundryRequestBooking.dart';
import '../components/PurchaseMoreScreen.dart';

class LSRequestScreen extends StatefulWidget {
  static String tag = '/LSRequestScreen';

  @override
  LSRequestScreenState createState() => LSRequestScreenState();
}

class LSRequestScreenState extends State<LSRequestScreen> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: appBarWidget(
          'Request Form',
          center: true,
          showBack: false,
          color: context.cardColor,
          actions: [
            
          ],
          bottom: TabBar(
            labelStyle: boldTextStyle(color: black, size: 18),
            unselectedLabelStyle: secondaryTextStyle(size: 16),
            labelColor: LSColorPrimary,
            unselectedLabelColor: appStore.isDarkModeOn ? white : black,
            isScrollable: false,
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Laundry Request'),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Dryclean Request'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LSLaundryRequestComponents(),
            PurchaseMoreScreen(),
          ],
        ),
      ),
    );
  }
}
