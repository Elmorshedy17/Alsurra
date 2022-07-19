import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_page.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_manager.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_response.dart';
import 'package:alsurrah/shared/activity_widget/activity_item.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OffersAndDiscountsArgs {
  final String type;
  final String title;

  OffersAndDiscountsArgs({required this.type, required this.title});
}

class OffersAndDiscountsPage extends StatefulWidget {
  const OffersAndDiscountsPage({Key? key}) : super(key: key);

  @override
  State<OffersAndDiscountsPage> createState() => _OffersAndDiscountsPageState();
}

class _OffersAndDiscountsPageState extends State<OffersAndDiscountsPage> {
  late final OffersAndDiscountsManager offersAndDiscountsManager;
  OffersAndDiscountsArgs? args;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      offersAndDiscountsManager = context.use<OffersAndDiscountsManager>();
      offersAndDiscountsManager.resetManager();

      // SchedulerBinding.instance?.addPostFrameCallback((_) {
      args =
          ModalRoute.of(context)!.settings.arguments as OffersAndDiscountsArgs;
      if (args != null) {
        offersAndDiscountsManager.reCallManager(type: args!.type);
      }
      // context.use<FestivalDetailsManager>().execute(FestivalId: args!.FestivalId);
      // });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (args == null) {
      offersAndDiscountsManager = context.use<OffersAndDiscountsManager>();
      args =
          ModalRoute.of(context)!.settings.arguments as OffersAndDiscountsArgs;
      offersAndDiscountsManager.reCallManager(type: args!.type);
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
        child: Observer<OffersAndDiscountsResponse>(
            onRetryClicked: () {
              offersAndDiscountsManager.reCallManager(type: args!.type);
            },
            stream: offersAndDiscountsManager.response$,
            onSuccess: (context, newsSnapshot) {
              offersAndDiscountsManager.updateOffersAndDiscountsList(
                  totalItemsCount: newsSnapshot.data?.info?.total ?? 0,
                  snapshotOffersAndDiscounts:
                      newsSnapshot.data?.discounts ?? []);
              return ListView(
                controller: offersAndDiscountsManager.scrollController,
                children: [
                  offersAndDiscountsManager.offersAndDiscountsList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 25, bottom: 15, right: 15, left: 15),
                          itemCount: offersAndDiscountsManager
                              .offersAndDiscountsList.length,
                          itemBuilder: (_, index) => Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ActivityItem(
                              imageUrl: offersAndDiscountsManager
                                  .offersAndDiscountsList[index].image!,
                              title: offersAndDiscountsManager
                                  .offersAndDiscountsList[index].name!,
                              date: offersAndDiscountsManager
                                  .offersAndDiscountsList[index].desc!,
                              price: offersAndDiscountsManager
                                  .offersAndDiscountsList[index].price!,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutesNames.offerOrDiscountPage,
                                  arguments: OfferOrDiscountArgs(
                                    offerOrDiscountId: offersAndDiscountsManager
                                        .offersAndDiscountsList[index].id!,
                                    offerOrDiscountTitle:
                                        offersAndDiscountsManager
                                            .offersAndDiscountsList[index].name,
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
                      stream: offersAndDiscountsManager.paginationState$,
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
                                await offersAndDiscountsManager.onErrorLoadMore(
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
