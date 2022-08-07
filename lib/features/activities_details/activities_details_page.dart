import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/activities_details/activities_details_manager.dart';
import 'package:alsurrah/features/activities_details/activities_details_response.dart';
import 'package:alsurrah/shared/counter_widget/counter_widget.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class ActivitiesDetailsArgs {
  final int activityId;
  final String? activityTitle;

  ActivitiesDetailsArgs({required this.activityId, this.activityTitle});
}

class ActivitiesDetailsPage extends StatefulWidget {
  const ActivitiesDetailsPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesDetailsPage> createState() => _ActivitiesDetailsPageState();
}

class _ActivitiesDetailsPageState extends State<ActivitiesDetailsPage> {
  String selectedImage = '';
  ActivitiesDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args =
      ModalRoute.of(context)!.settings.arguments as ActivitiesDetailsArgs;
      if (args != null) {
        locator<ActivityDetailsManager>().execute(activityId: args!.activityId);
        locator<ActivityDetailsManager>().counterSubject.sink.add(1);
      }
      // context.use<NewsDetailsManager>().execute(newsId: args!.newsId);
    });

    locator<ActivityDetailsManager>().showZoomable =
        ShowZoomable.hide;
  }

  @override
  Widget build(BuildContext context) {
    final activityDetailsManager = context.use<ActivityDetailsManager>();

    if (args == null) {
      args =
      ModalRoute.of(context)!.settings.arguments as ActivitiesDetailsArgs;
      activityDetailsManager.execute(activityId: args!.activityId);
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
          title: "${args?.activityTitle}",
        ),
        // ),
      ),
      body: Observer<ActivityDetailsResponse>(
          stream: activityDetailsManager.activityDetails$,
          onRetryClicked: () {
            activityDetailsManager.execute(activityId: args!.activityId);
          },
          onSuccess: (context, activityDetailsSnapshot) {
            return

              ValueListenableBuilder<ShowZoomable>(
                  valueListenable:
                  activityDetailsManager.showZoomableNotifier,
                  builder: (context, value, _) {
                    return Stack(
                      children: [
                        ListView(
                          children: [
                            InkWell(
                              onTap: (){
                                selectedImage = '${activityDetailsSnapshot.data?.activityDetails?.image}';
                                activityDetailsManager.showZoomable =
                                    ShowZoomable.show;
                              },
                              child: NetworkAppImage(
                                height: 300.h,
                                width: double.infinity,
                                boxFit: BoxFit.fill,
                                imageUrl:
                                '${activityDetailsSnapshot.data?.activityDetails?.image}',
                                // imageUrl: '${e}',
                              ),
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
                                    '${activityDetailsSnapshot.data?.activityDetails?.name}',
                                    style: AppFontStyle.biggerBlueLabel,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'التاريخ:${activityDetailsSnapshot.data?.activityDetails?.date}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${activityDetailsSnapshot.data?.activityDetails?.price}',
                                        style: AppFontStyle.darkGreyLabel
                                            .copyWith(color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'بدلا من',
                                        style: AppFontStyle.darkGreyLabel
                                            .copyWith(color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${activityDetailsSnapshot.data?.activityDetails?.oldPrice}',
                                        style: AppFontStyle.darkGreyLabel.copyWith(
                                          color: Colors.black.withOpacity(.6),
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                  ),
                                  Html(
                                    data:
                                    '${activityDetailsSnapshot.data?.activityDetails?.desc}',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CounterWidget(
                                    stream: activityDetailsManager.selectedCount$,
                                    maxCount: activityDetailsSnapshot
                                        .data?.activityDetails?.count ??
                                        0,
                                    onDecrement: () {
                                      activityDetailsManager.counterSubject.sink.add(
                                          activityDetailsManager.counterSubject.value - 1);
                                    },
                                    onIncrement: () {
                                      activityDetailsManager.counterSubject.sink.add(
                                          activityDetailsManager.counterSubject.value + 1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Center(
                                child: MainButtonWidget(
                                    title: "حجز",
                                    onClick: () {

                                    },
                                    width: MediaQuery.of(context).size.width * .85)
                            ),
                          ],
                        ),
                        if (value == ShowZoomable.show)
                          Positioned.fill(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: PhotoView(
                                    backgroundDecoration:
                                    const BoxDecoration(
                                        color: Colors.black38),
                                    minScale: PhotoViewComputedScale.contained * 0.3,
                                    initialScale: PhotoViewComputedScale.contained * 0.8,
                                    imageProvider: NetworkImage(
                                        selectedImage,
                                        scale: 1
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 30,
                                  child: FloatingActionButton(
                                    // mini: true,
                                    onPressed: () {
                                      activityDetailsManager.showZoomable =
                                          ShowZoomable.hide;
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  });
              
             
          }),
    );
  }
}
