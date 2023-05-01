import 'package:flutter/material.dart';
import 'package:urban_laundry_mobile/utils/LSContstants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseMoreScreen extends StatelessWidget {
  final bool? enableAppbar;

  PurchaseMoreScreen({this.enableAppbar = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Icon(Icons.arrow_back, size: 24).paddingAll(16).onTap(() {
              finish(context);
            }).visible(enableAppbar!),
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: boxDecorationDefault(),
                    padding: EdgeInsets.all(16),
                    child: Image.asset("assets/images/laundry_app_logo.png", height: 100),
                  ),
                  22.height,
                  Text(
                    'This features is not available in this version',
                    style: boldTextStyle(size: 22),
                    textAlign: TextAlign.center,
                  ),
                  16.height,
                 
                ],
              ),
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
