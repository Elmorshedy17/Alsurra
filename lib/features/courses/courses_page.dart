import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/course_details/course_details_page.dart';
import 'package:alsurrah/features/courses/courses_manager.dart';
import 'package:alsurrah/features/courses/courses_response.dart';
import 'package:alsurrah/shared/activity_widget/activity_item.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late final CoursesManager coursesManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      coursesManager = context.use<CoursesManager>();
      coursesManager.resetManager();
      coursesManager.reCallManager();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "الدورات",
        ),
        // ),
      ),
      body: SafeArea(
        top: false,
        child: Observer<CoursesResponse>(
            onRetryClicked: coursesManager.reCallManager,
            stream: coursesManager.response$,
            onSuccess: (context, activitiesSnapshot) {
              coursesManager.updateCoursesList(
                  totalItemsCount: activitiesSnapshot.data?.info?.total ?? 0,
                  snapshotCourses: activitiesSnapshot.data?.courses ?? []);
              return ListView(
                controller: coursesManager.scrollController,
                children: [
                  coursesManager.courses.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 15, right: 15, left: 15),
                          itemCount: coursesManager.courses.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ActivityItem(
                              imageUrl: coursesManager.courses[index].image!,
                              title: coursesManager.courses[index].name!,
                              date: coursesManager.courses[index].desc!,
                              price: coursesManager.courses[index].price!,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutesNames.courseDetailsPage,
                                  arguments: CourseDetailsArgs(
                                      courseId:
                                          coursesManager.courses[index].id!,
                                      courseTitle:
                                          coursesManager.courses[index].name),
                                );
                              },
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 150.h,
                            ),
                            NotAvailableComponent(
                              view: const FaIcon(
                                FontAwesomeIcons.squarePollHorizontal,
                                color: AppStyle.darkOrange,
                                size: 100,
                              ),
                              title: 'لا توجد دورات متاحة',
                              titleTextStyle: AppFontStyle.biggerBlueLabel
                                  .copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900),
                              // ('no News'),
                            ),
                          ],
                        ),
                  StreamBuilder<PaginationState>(
                      initialData: PaginationState.idle,
                      stream: coursesManager.paginationState$,
                      builder: (context, paginationStateSnapshot) {
                        if (paginationStateSnapshot.data ==
                            PaginationState.loading) {
                          return const ListTile(
                              title: Center(
                            child: SpinKitWave(
                              color: AppStyle.darkOrange,
                              itemCount: 5,
                              size: 30.0,
                            ),
                          ));
                        }
                        if (paginationStateSnapshot.data ==
                            PaginationState.error) {
                          return ListTile(
                            leading: const Icon(Icons.error),
                            title: Text(
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'Something Went Wrong Try Again Later'
                                  : 'حدث خطأ ما حاول مرة أخرى لاحقاً',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                await coursesManager.onErrorLoadMore();
                              },
                              child: Text(
                                  locator<PrefsService>().appLanguage == 'en'
                                      ? 'Retry'
                                      : 'أعد المحاولة'),
                            ),
                          );
                        }
                        return const SizedBox(
                          width: 0,
                          height: 0,
                        );
                      }),
                ],
              );
            }),
      ),
    );
  }
}
