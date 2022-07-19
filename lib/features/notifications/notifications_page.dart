import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/notifications/notifications_manager.dart';
import 'package:alsurrah/features/notifications/notifications_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsManager notificationsManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      notificationsManager = context.use<NotificationsManager>();
      notificationsManager.resetManager();
      notificationsManager.reCallManager();
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
          title: "الاشعارات",
        ),
        // ),
      ),
      body: SafeArea(
        top: false,
        child: Observer<NotificationsResponse>(
            onRetryClicked: notificationsManager.reCallManager,
            stream: notificationsManager.response$,
            onSuccess: (context, festivalSnapshot) {
              notificationsManager.updateNotificationsList(
                  totalItemsCount: festivalSnapshot.data?.info?.total ?? 0,
                  snapshotNotifications:
                      festivalSnapshot.data?.notifications ?? []);
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  controller: notificationsManager.scrollController,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    notificationsManager.notificationsList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                notificationsManager.notificationsList.length,
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: Card(
                                elevation: 2.0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  side: BorderSide(
                                      width: 0.1, color: Colors.grey),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${notificationsManager.notificationsList[index].date}",
                                            style: AppFontStyle.descFont
                                                .copyWith(
                                                    fontSize: 11,
                                                    color: AppStyle.mediumGrey
                                                        .withOpacity(.7)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.bell,
                                            color: AppStyle.lightGrey,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Text(
                                            "${notificationsManager.notificationsList[index].message}",
                                            style: AppFontStyle.descFont
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: AppStyle.mediumGrey
                                                        .withOpacity(.9)),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                  FontAwesomeIcons.bellSlash,
                                  color: AppStyle.darkOrange,
                                  size: 100,
                                ),
                                title: 'لا توجد اشعارات متاحة',
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
                        stream: notificationsManager.paginationState$,
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
                                  await notificationsManager.onErrorLoadMore();
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
                ),
              );
            }),
      ),
    );
  }
}
