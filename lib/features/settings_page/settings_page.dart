import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/pages/pages_manager.dart';
import 'package:alsurrah/features/pages/pages_page.dart';
import 'package:alsurrah/features/pages/pages_response.dart';
import 'package:alsurrah/features/settings_page/settings_manager.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/settings_item/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final prefs = locator<PrefsService>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<PagesManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pagesManager = context.use<PagesManager>();
    final settingsManager = context.use<SettingsManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "عن التطبيق",
        ),
        // ),
      ),
      body: Observer<PagesResponse>(
          stream: pagesManager.pages$,
          onRetryClicked: () {
            context.use<PagesManager>().execute();
          },
          onSuccess: (context, pagesSnapshot) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
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
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: pagesSnapshot.data!.pages!.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  height: 30,
                                );
                              },
                              itemBuilder: (context, index) {
                                return SettingsItem(
                                  title:
                                      "${pagesSnapshot.data!.pages![index].title}",
                                  onClick: () {
                                    locator<NavigationService>().pushNamedTo(
                                        AppRoutesNames.pagesPage,
                                        arguments: PagesArgs(
                                            title:
                                                "${pagesSnapshot.data!.pages![index].title}",
                                            body:
                                                "${pagesSnapshot.data!.pages![index].desc}"));
                                  },
                                );
                              },
                            ),
                            const Divider(
                              height: 30,
                            ),
                            SettingsItem(
                              title: "الأسئلة الشائعة",
                              onClick: () {
                                locator<NavigationService>().pushNamedTo(
                                  AppRoutesNames.faqPage,
                                );
                              },
                            ),
                            const Divider(
                              height: 30,
                            ),
                            SettingsItem(
                              title: "تواصل معنا",
                              onClick: () {
                                locator<NavigationService>().pushNamedTo(
                                  AppRoutesNames.contactUsPage,
                                );
                              },
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
                          title: "تفعيل الاشعارات",
                          // onClick: (){},
                          leadingWidget: ValueListenableBuilder<bool>(
                              valueListenable:
                                  settingsManager.notificationsSwitch,
                              builder: (_, value, __) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'إيقاف',
                                      // '',
                                      style: TextStyle(
                                          color: value
                                              ? AppStyle.darkGrey
                                              : AppStyle.darkOrange,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Transform.scale(
                                      scale: 0.7,
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppStyle.darkOrange, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: CupertinoSwitch(
                                          thumbColor: AppStyle.darkOrange,
                                          activeColor: Colors.transparent,
                                          trackColor: Colors.transparent,
                                          value: value,
                                          onChanged: (bool newValue) {
                                            settingsManager
                                                .switchNotifications(newValue);

                                            prefs.notificationFlag = newValue;

                                            // if( prefs.notificationFlag == false){
                                            //   _fcm.unsubscribeFromTopic('IosEn${prefs.currencyId}');
                                            //   _fcm.unsubscribeFromTopic('IosAr${prefs.currencyId}');
                                            //   _fcm.unsubscribeFromTopic('AndroidEn${prefs.currencyId}');
                                            //   _fcm.unsubscribeFromTopic('AndroidAr${prefs.currencyId}');
                                            //
                                            //   if (Platform.isIOS) {
                                            //     _fcm.subscribeToTopic('IOS');
                                            //   } else if (Platform.isAndroid) {
                                            //     _fcm.subscribeToTopic('Android');
                                            //   }
                                            // }else{
                                            //   _fcm.unsubscribeFromTopic('IosEn${prefs.currencyId}');
                                            //   _fcm.unsubscribeFromTopic('IosAr${prefs.currencyId}');
                                            //   _fcm.unsubscribeFromTopic('AndroidEn${prefs.currencyId}');
                                            //   _fcm.unsubscribeFromTopic('AndroidAr${prefs.currencyId}');
                                            //
                                            //   if (Platform.isIOS) {
                                            //     if (prefs.appLanguage == 'en') {
                                            //       _fcm.subscribeToTopic('IosEn${prefs.currencyId}');
                                            //     } else {
                                            //       _fcm.subscribeToTopic('IosAr${prefs.currencyId}');
                                            //     }
                                            //   } else {
                                            //     if (prefs.appLanguage == 'en') {
                                            //       _fcm.subscribeToTopic('AndroidEn${prefs.currencyId}');
                                            //     } else {
                                            //       _fcm.subscribeToTopic('AndroidAr${prefs.currencyId}');
                                            //     }
                                            //   }
                                            // }
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'تشغيل',
                                      style: TextStyle(
                                          color: value
                                              ? AppStyle.darkOrange
                                              : AppStyle.darkGrey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        SettingsItem(
                          title: " قيم التطبيق",
                          onClick: () {},
                        ),
                        const Divider(
                          height: 30,
                        ),
                        SettingsItem(
                          title: "مشاركة التطبيق",
                          onClick: () async {
                            if (Platform.isAndroid) {
                              await Share.share('share andriod');
                            } else if (Platform.isIOS) {
                              await Share.share('share ios');
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
