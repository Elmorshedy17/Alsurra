import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/festival_details/festival_details_page.dart';
import 'package:alsurrah/features/festivals/festivals_manager.dart';
import 'package:alsurrah/features/festivals/festivals_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/image_title__withborder_widget/image_title_widget_withborder.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FestivalsPage extends StatefulWidget {
  const FestivalsPage({Key? key}) : super(key: key);

  @override
  State<FestivalsPage> createState() => _FestivalsPageState();
}

class _FestivalsPageState extends State<FestivalsPage> {
  late final FestivalsManager festivalsManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      festivalsManager = context.use<FestivalsManager>();
      festivalsManager.resetManager();
      festivalsManager.reCallManager();
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
          title: "المهرجانات والعروض",
        ),
        // ),
      ),
      body: SafeArea(
        top: false,
        child: Observer<FestivalsResponse>(
            onRetryClicked: festivalsManager.reCallManager,
            stream: festivalsManager.response$,
            onSuccess: (context, festivalSnapshot) {
              festivalsManager.updateFestivalsList(
                  totalItemsCount: festivalSnapshot.data?.info?.total ?? 0,
                  snapshotFestivals: festivalSnapshot.data?.offers ?? []);
              return ListView(
                controller: festivalsManager.scrollController,
                children: [
                  festivalsManager.festivalsList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 15, right: 15, left: 15),
                          itemCount: festivalsManager.festivalsList.length,
                          itemBuilder: (_, index) => Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ImageTitleBorder(
                              imageUrl:
                                  festivalsManager.festivalsList[index].image,
                              title: festivalsManager.festivalsList[index].name,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutesNames.festivalDetailsPage,
                                  arguments: FestivalDetailsArgs(
                                      festivalId: festivalsManager
                                          .festivalsList[index].id!,
                                      festivalTitle: festivalsManager
                                          .festivalsList[index].name),
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
                              title: 'لا توجد مهرجانات / عروض متاحة',
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
                      stream: festivalsManager.paginationState$,
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
                                await festivalsManager.onErrorLoadMore();
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
