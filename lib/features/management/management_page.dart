import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/management/management_manager.dart';
import 'package:alsurrah/features/management/management_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/managment_item/managment_item.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      locator<ManagementManager>().execute();

      // context.use<ManagementManager>().execute(newsId: args!.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final managementManager = context.use<ManagementManager>();

    // locator<ManagementManager>().execute(newsId: args!.newsId);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "مجلس الإدارة",
        ),
        // ),
      ),
      body: Observer<ManagementResponse>(
          stream: managementManager.management$,
          onRetryClicked: () {
            managementManager.execute();
          },
          onSuccess: (context, managementSnapshot) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: managementSnapshot.data!.members!.isNotEmpty
                  ? ListView.builder(
                      // padding: const EdgeInsets.only(top: 24, bottom: 70,right: 15,left: 15),
                      itemCount: managementSnapshot.data!.members!.length,
                      itemBuilder: (_, index) => ManagementItem(
                            title:
                                managementSnapshot.data!.members![index].name,
                            job: managementSnapshot.data!.members![index].job,
                            imgUrl:
                                managementSnapshot.data!.members![index].image,
                            special: managementSnapshot
                                .data!.members![index].special,
                          ))
                  : NotAvailableComponent(
                      view: const FaIcon(
                        FontAwesomeIcons.users,
                        color: AppStyle.darkOrange,
                        size: 100,
                      ),
                      title: 'لا يوجد اعضاء مجلس ادارة متاحيين',
                      titleTextStyle: AppFontStyle.biggerBlueLabel.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.w900),
                      // ('no News'),
                    ),
            );
          }),
    );
  }
}
