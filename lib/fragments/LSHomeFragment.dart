import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:urban_laundry_mobile/components/LSLaundryPriceTable.dart';
import 'package:urban_laundry_mobile/utils/LSColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../components/LSSOfferPackageComponent.dart';
import '../components/LSServiceNearByComponent.dart';
import '../components/LSTopServiceComponent.dart';
import '../main.dart';
import '../screens/LSNearByScreen.dart';
import '../screens/LSNotificationScreen.dart';
import '../screens/LSOfferAllScreen.dart';

class LSHomeFragment extends StatefulWidget {
  static String tag = '/LSHomeFragment';

  @override
  LSHomeFragmentState createState() => LSHomeFragmentState();
}

class LSHomeFragmentState extends State<LSHomeFragment> {
  // Future<List<dynamic>> getPriceList() async {
  //   final response = await http.get(Uri.parse('http://192.168.1.12/urban_laundry/user/api/laundry_pricelist.php'));
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }
  // List<int> _data = [];

  Future<List<dynamic>> getPriceList() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/urban_laundry/user/api/laundry_pricelist.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<void> getPriceList() async {
  //   final response = await http.get(Uri.parse(
  //       'http://192.168.1.12/urban_laundry/user/api/laundry_pricelist.php'));
  //   final responseData = json.decode(response.body);
  //   setState(() {
  //     _data = responseData;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await 2.microseconds.delay;
    setStatusBarColor(
        appStore.isDarkModeOn ? context.cardColor : LSColorPrimary);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 210,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            pinned: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor:
                appStore.isDarkModeOn ? context.cardColor : LSColorPrimary,
            actionsIconTheme: IconThemeData(opacity: 0.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: SessionManager().get('token'),
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          Text('Hello, ',
                              style: boldTextStyle(color: white, size: 20)),
                          Text(snapshot.hasData ? snapshot.data : 'Loading...',
                              style: boldTextStyle(color: white, size: 20)),
                        ],
                      );
                    }).paddingOnly(left: 16, right: 16, bottom: 8),
                IconButton(
                    onPressed: () {
                      LSNotificationScreen().launch(context);
                    },
                    icon: Icon(Icons.notifications, color: white))
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Your Location',
                          style: primaryTextStyle(color: white, size: 12))
                      .paddingOnly(left: 16, right: 16, top: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.location_on,
                                      color: white, size: 16)
                                  .paddingRight(4),
                            ),
                            TextSpan(
                                text: 'Aizawl, MZ',
                                style: primaryTextStyle(color: white)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            // WidgetSpan(
                            //   child: Icon(Icons.airplanemode_on_outlined, color: white, size: 16).paddingRight(4),
                            // ),
                            TextSpan(
                                text: 'Change',
                                style: primaryTextStyle(color: white)),
                          ],
                        ),
                      ),
                    ],
                  ).paddingAll(16),
                  Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: context.scaffoldBackgroundColor),
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: white,
                        hintText: 'Search Laundry shop by name...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: grey),
                        contentPadding: EdgeInsets.only(
                            left: 24.0, bottom: 8.0, top: 8.0, right: 24.0),
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ).paddingTop(70),
            ),
          )
        ];
      },
      body: Container(
        color: appStore.isDarkModeOn
            ? context.scaffoldBackgroundColor
            : LSColorSecondary.withOpacity(0.55),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.height,
              Text('Laundry Status', style: boldTextStyle(size: 18))
                  .paddingOnly(left: 16, top: 16, right: 16, bottom: 8),
              LSTopServiceComponent(),
              Text('Laundry Pricing', style: boldTextStyle(size: 18))
                  .paddingOnly(left: 16, top: 16, right: 16,),
              LSLaundryPriceTable(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Service we provide', style: boldTextStyle(size: 18))
                      .expand(),
                  TextButton(
                      onPressed: () {
                        LSNearByScreen().launch(context);
                      },
                      child: Text('View All', style: secondaryTextStyle()))
                ],
              ).paddingOnly(left: 16, top: 16, right: 16),
              LSServiceNearByComponent(),
              Row(
                children: [
                  Text('Special Package & Offers',
                          style: boldTextStyle(size: 18))
                      .expand(),
                  TextButton(
                      onPressed: () {
                        LSOfferAllScreen().launch(context);
                      },
                      child: Text('View All', style: secondaryTextStyle()))
                ],
              ).paddingOnly(left: 16, right: 16),
              LSSOfferPackageComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
