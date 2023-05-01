import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';

import '../model/LSUserModel.dart';

class RememberUserPrefs {
  static Future<void> saveRememberUser(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }
}
