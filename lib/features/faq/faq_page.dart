import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/faq/faq_manager.dart';
import 'package:alsurrah/features/faq/faq_response.dart';
import 'package:alsurrah/shared/custom_list_tile/custom_list_tile.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<FAQManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final faqManager = context.use<FAQManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "الأسئلة الشائعة",
        ),
        // ),
      ),
      body: Observer<FAQResponse>(
          stream: faqManager.faq$,
          onRetryClicked: () {
            context.use<FAQManager>().execute();
          },
          onSuccess: (context, festivalDetailsSnapshot) {
            return Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.all(15),
              child: festivalDetailsSnapshot.data!.faq!.isNotEmpty
                  ? ListView.builder(
                      itemCount: festivalDetailsSnapshot.data!.faq!.length,
                      // itemCount: festivalDetailsSnapshot.data!.faq!.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppStyle.darkOrange),
                          ),
                          child: CustomAnimatedOpenTile(
                            headerTxt:
                                festivalDetailsSnapshot.data!.faq![index].name,
                            body: Text(
                              "${festivalDetailsSnapshot.data!.faq![index].desc}",
                              style: AppFontStyle.descFont,
                            ),
                          ),
                        );
                      })
                  : NotAvailableComponent(
                      view: const FaIcon(
                        FontAwesomeIcons.question,
                        color: AppStyle.darkOrange,
                        size: 100,
                      ),
                      title: 'لا توجد اسئلة شائعة متاحة',
                      titleTextStyle: AppFontStyle.biggerBlueLabel.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.w900),
                      // ('no News'),
                    ),
            );
          }),
    );
  }
}
