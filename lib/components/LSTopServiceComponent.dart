import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/LSServiceModel.dart';
import '../screens/ServiceDetail/LSServiceDetailScreen.dart';
import '../utils/LSWidgets.dart';

class LSTopServiceComponent extends StatefulWidget {
  static String tag = '/TopServiceComponent';

  @override
  LSTopServiceComponentState createState() => LSTopServiceComponentState();
}

class LSTopServiceComponentState extends State<LSTopServiceComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      itemCount: getTopServiceList().length,
      itemBuilder: (BuildContext context, int index) {
        LSServiceModel data = getTopServiceList()[index];

        return Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
              height: 72,
              width: 72,
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              decoration: boxDecorationRoundedWithShadow(40, backgroundColor: context.cardColor),
              child: commonCacheImageWidget(data.img.validate(), 40, width: 40, fit: BoxFit.cover),
            )
            ),
            
            8.height,
            Text(data.title.validate(), style: primaryTextStyle()),
          ],
        ).onTap(() {
          LSServiceDetailScreen().launch(context);
        });
      },
    );
  }
}
