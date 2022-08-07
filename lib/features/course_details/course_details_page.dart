import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/course_details/course_details_manager.dart';
import 'package:alsurrah/features/course_details/course_details_response.dart';
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

class CourseDetailsArgs {
  final int courseId;
  final String? courseTitle;

  CourseDetailsArgs({required this.courseId, this.courseTitle});
}

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({Key? key}) : super(key: key);

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  String selectedImage = '';
  CourseDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as CourseDetailsArgs;
      if (args != null) {
        locator<CourseDetailsManager>().execute(courseId: args!.courseId);
        locator<CourseDetailsManager>().counterSubject.sink.add(1);
      }
      // context.use<NewsDetailsManager>().execute(newsId: args!.newsId);
    });

    locator<CourseDetailsManager>().showZoomable =
        ShowZoomable.hide;
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailsManager = context.use<CourseDetailsManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as CourseDetailsArgs;
      courseDetailsManager.execute(courseId: args!.courseId);
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
          title: "${args?.courseTitle}",
        ),
        // ),
      ),
      body: Observer<CourseDetailsResponse>(
          stream: courseDetailsManager.courseDetails$,
          onRetryClicked: () {
            courseDetailsManager.execute(courseId: args!.courseId);
          },
          onSuccess: (context, courseDetailsSnapshot) {
            return

              ValueListenableBuilder<ShowZoomable>(
                  valueListenable:
                  courseDetailsManager.showZoomableNotifier,
                  builder: (context, value, _) {
                    return Stack(
                      children: [
                        ListView(
                          children: [
                            InkWell(
                              onTap: (){
                                selectedImage = '${courseDetailsSnapshot.data?.courseDetails?.image}';
                                courseDetailsManager.showZoomable =
                                    ShowZoomable.show;
                              },
                              child: NetworkAppImage(
                                height: 300.h,
                                width: double.infinity,
                                boxFit: BoxFit.fill,
                                imageUrl:
                                '${courseDetailsSnapshot.data?.courseDetails?.image}',
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
                                    '${courseDetailsSnapshot.data?.courseDetails?.name}',
                                    style: AppFontStyle.biggerBlueLabel,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'التاريخ:${courseDetailsSnapshot.data?.courseDetails?.date}',
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
                                        '${courseDetailsSnapshot.data?.courseDetails?.price}',
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
                                        '${courseDetailsSnapshot.data?.courseDetails?.oldPrice}',
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
                                  Row(children: [
                                    Text(
                                      'الفئة العمرية: ',
                                      style: AppFontStyle.blueLabel,
                                    ),
                                    Text(
                                      '${courseDetailsSnapshot.data!.courseDetails!.category}',
                                      style: AppFontStyle.darkGreyLabel,
                                    ),
                                  ]),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                  ),
                                  Html(
                                    data:
                                    '${courseDetailsSnapshot.data?.courseDetails?.desc}',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CounterWidget(
                                    stream: courseDetailsManager.selectedCount$,
                                    maxCount:
                                    courseDetailsSnapshot.data?.courseDetails?.count ??
                                        0,
                                    onDecrement: () {
                                      courseDetailsManager.counterSubject.sink.add(
                                          courseDetailsManager.counterSubject.value - 1);
                                    },
                                    onIncrement: () {
                                      courseDetailsManager.counterSubject.sink.add(
                                          courseDetailsManager.counterSubject.value + 1);
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
                            )
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
                                      courseDetailsManager.showZoomable =
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
