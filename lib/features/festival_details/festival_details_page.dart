import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/festival_details/festival_details_manager.dart';
import 'package:alsurrah/features/festival_details/festival_details_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FestivalDetailsArgs {
  final int festivalId;
  final String? festivalTitle;

  FestivalDetailsArgs({required this.festivalId, this.festivalTitle});
}

class FestivalDetailsPage extends StatefulWidget {
  const FestivalDetailsPage({Key? key}) : super(key: key);

  @override
  State<FestivalDetailsPage> createState() => _FestivalDetailsPageState();
}

class _FestivalDetailsPageState extends State<FestivalDetailsPage> {
  FestivalDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as FestivalDetailsArgs;
      if (args != null) {
        locator<FestivalDetailsManager>().execute(festivalId: args!.festivalId);
      }
      // context.use<FestivalDetailsManager>().execute(FestivalId: args!.FestivalId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final festivalDetailsManager = context.use<FestivalDetailsManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as FestivalDetailsArgs;
      locator<FestivalDetailsManager>().execute(festivalId: args!.festivalId);
    }

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
          title: "${args?.festivalTitle}",
        ),
        // ),
      ),
      body: Observer<FestivalDetailsResponse>(
          stream: festivalDetailsManager.festivalDetails$,
          onRetryClicked: () {
            festivalDetailsManager.execute(festivalId: args!.festivalId);
          },
          onSuccess: (context, festivalDetailsSnapshot) {
            return ListView(
              children: [
                NetworkAppImage(
                  height: 200.h,
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                  imageUrl: '${festivalDetailsSnapshot.data!.offer!.image}',
                  // imageUrl: '${e}',
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${festivalDetailsSnapshot.data!.offer?.name}',
                        style: AppFontStyle.biggerBlueLabel,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'تاريخ البدء : ${festivalDetailsSnapshot.data!.offer?.startDate}',
                        style: AppFontStyle.descFont,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'تاريخ الانتهاء : ${festivalDetailsSnapshot.data!.offer?.endDate}',
                        style: AppFontStyle.descFont,
                      ),
                      Html(
                        data: '${festivalDetailsSnapshot.data!.offer?.desc}',
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
