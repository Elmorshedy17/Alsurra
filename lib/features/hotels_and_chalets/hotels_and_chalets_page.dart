import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_page.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_manager.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_response.dart';
import 'package:alsurrah/shared/activity_widget/activity_item.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HotelAndChaletsArgs {
  final String type;
  final String title;

  HotelAndChaletsArgs({required this.type, required this.title});
}

class HotelAndChaletsPage extends StatefulWidget {
  const HotelAndChaletsPage({Key? key}) : super(key: key);

  @override
  State<HotelAndChaletsPage> createState() => _HotelAndChaletsPageState();
}

class _HotelAndChaletsPageState extends State<HotelAndChaletsPage> {
  late final HotelAndChaletsManager hotelAndChaletsManager;
  HotelAndChaletsArgs? args;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      hotelAndChaletsManager = context.use<HotelAndChaletsManager>();
      hotelAndChaletsManager.resetManager();

      // SchedulerBinding.instance?.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as HotelAndChaletsArgs;
      if (args != null) {
        hotelAndChaletsManager.reCallManager(type: args!.type);
      }
      // context.use<FestivalDetailsManager>().execute(FestivalId: args!.FestivalId);
      // });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (args == null) {
      hotelAndChaletsManager = context.use<HotelAndChaletsManager>();
      args = ModalRoute.of(context)!.settings.arguments as HotelAndChaletsArgs;
      hotelAndChaletsManager.reCallManager(type: args!.type);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: args!.title,
        ),
        // ),
      ),
      body: SafeArea(
        top: false,
        child: Observer<HotelAndChaletsResponse>(
            onRetryClicked: () {
              hotelAndChaletsManager.reCallManager(type: args!.type);
            },
            stream: hotelAndChaletsManager.response$,
            onSuccess: (context, hotelAndChaletSnapshot) {
              hotelAndChaletsManager.updateHotelAndChaletsList(
                  totalItemsCount:
                      hotelAndChaletSnapshot.data?.info?.total ?? 0,
                  snapshotHotelAndChalets:
                      hotelAndChaletSnapshot.data?.hotels ?? []);
              return ListView(
                controller: hotelAndChaletsManager.scrollController,
                children: [
                  hotelAndChaletsManager.hotelAndChaletsList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 25, bottom: 15, right: 15, left: 15),
                          itemCount:
                              hotelAndChaletsManager.hotelAndChaletsList.length,
                          itemBuilder: (_, index) => Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ActivityItem(
                              imageUrl: hotelAndChaletsManager
                                  .hotelAndChaletsList[index].image!,
                              title: hotelAndChaletsManager
                                  .hotelAndChaletsList[index].name!,
                              date: hotelAndChaletsManager
                                  .hotelAndChaletsList[index].desc!,
                              price: hotelAndChaletsManager
                                  .hotelAndChaletsList[index].price!,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutesNames.hotelOrChaletPage,
                                  arguments: HotelOrChaletArgs(
                                    hotelOrChaletId: hotelAndChaletsManager
                                        .hotelAndChaletsList[index].id!,
                                    hotelOrChaletTitle: hotelAndChaletsManager
                                        .hotelAndChaletsList[index].name,
                                  ),
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
                                FontAwesomeIcons.tags,
                                color: AppStyle.darkOrange,
                                size: 100,
                              ),
                              title:
                                  'لا توجد ${args!.title.replaceFirst("ال", "")} متاحة ',
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
                      stream: hotelAndChaletsManager.paginationState$,
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
                                await hotelAndChaletsManager.onErrorLoadMore(
                                    type: args!.type);
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
