import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_response.dart';
import 'package:alsurrah/features/profits/profits_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:alsurrah/app_core/app_core.dart';

class ProfitsResultsPageArgs {
  final ProfitsResponse? profitsResponse;

  ProfitsResultsPageArgs({required this.profitsResponse,});
}

class ProfitsResultsPage extends StatefulWidget {
  const ProfitsResultsPage({Key? key}) : super(key: key);

  @override
  State<ProfitsResultsPage> createState() => _ProfitsResultsPageState();
}

class _ProfitsResultsPageState extends State<ProfitsResultsPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProfitsResultsPageArgs;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: false,
          title: "أرباح المساهمين",
        ),
        // ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FadeInRightBig(
                child: FaIcon(
                  FontAwesomeIcons.checkToSlot,
                  color: AppStyle.green,
                  size: 100.sp,
                ),
              ),
            ),
             SizedBox(
              height: 25.h,
            ),
            FadeInLeftBig(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("الاسم : ${args.profitsResponse!.data!.profit!.name}"),
                  Text("رقم الصندوق : ${args.profitsResponse!.data!.profit!.box}"),
                  Text("الرقم المدني : ${args.profitsResponse!.data!.profit!.civilId}"),
                  Text("المبلغ : ${args.profitsResponse!.data!.profit!.amount}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
