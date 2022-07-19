import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/shared/settings_item/settings_item.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final prefs = locator<PrefsService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          if (prefs.userObj != null)
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppStyle.lightGrey),
                  ),
                  child: Column(
                    children: [
                      SettingsItem(
                        title: "تفاصيل الحساب",
                        onClick: () {
                          locator<NavigationService>().pushNamedTo(
                            AppRoutesNames.accountDetailsPage,
                          );
                        },
                      ),
                      const Divider(
                        height: 30,
                      ),
                      SettingsItem(
                        title: "حجوزاتي",
                        onClick: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppStyle.lightGrey),
            ),
            child: Column(
              children: [
                SettingsItem(
                  title: "عن التطبيق",
                  onClick: () {
                    locator<NavigationService>().pushNamedTo(
                      AppRoutesNames.settingsPage,
                    );
                  },
                  trailingWidget: const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    color: AppStyle.darkGrey,
                    size: 18,
                  ),
                ),
                const Divider(
                  height: 30,
                ),
                prefs.userObj == null
                    ? SettingsItem(
                        title: "تسجيل الدخول",
                        onClick: () {
                          Navigator.of(context).pushNamed(
                            AppRoutesNames.loginPage,
                          );
                        },
                        trailingWidget: SvgPicture.asset(
                          AppAssets.login,
                          height: 18,
                        ),
                      )
                    : SettingsItem(
                        title: "تسجيل الخروج",
                        onClick: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text("هل تريد تسجيل الخروج"),
                              // content: new Text("This is my content"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: const Text("نعم"),
                                  onPressed: () {
                                    _fcm.unsubscribeFromTopic('Ios');
                                    _fcm.unsubscribeFromTopic('Android');

                                    if (Platform.isIOS) {
                                      _fcm.subscribeToTopic('IO');
                                    } else if (Platform.isAndroid) {
                                      _fcm.subscribeToTopic('And');
                                    }
                                    locator<PrefsService>().removeUserObj();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            AppRoutesNames.loginPage,
                                            (Route<dynamic> route) => false);
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: const Text("الغاء"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        trailingWidget: SvgPicture.asset(
                          AppAssets.logout,
                          height: 18,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
