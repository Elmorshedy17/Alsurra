import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/booking/booking_manager.dart';
import 'package:alsurrah/features/booking/booking_request.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_manager.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/counter_widget/counter_widget.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class OfferOrDiscountArgs {
  final int offerOrDiscountId;
  final String? offerOrDiscountTitle;

  OfferOrDiscountArgs(
      {required this.offerOrDiscountId, this.offerOrDiscountTitle});
}

class OfferOrDiscountPage extends StatefulWidget {
  const OfferOrDiscountPage({Key? key}) : super(key: key);

  @override
  State<OfferOrDiscountPage> createState() => _OfferOrDiscountPageState();
}

class _OfferOrDiscountPageState extends State<OfferOrDiscountPage> {
  String selectedImage = '';

  // final _familyCardTextEditing = TextEditingController();

  OfferOrDiscountArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as OfferOrDiscountArgs;
      if (args != null) {
        locator<OfferOrDiscountManager>()
            .execute(offerOrDiscountId: args!.offerOrDiscountId);
      }
      // context.use<OfferOrDiscountManager>().execute(newsId: args!.newsId);
    });
    locator<OfferOrDiscountManager>().showZoomable =
        ShowZoomable.hide;
  }

  @override
  Widget build(BuildContext context) {
    final offerOrDiscountManager = context.use<OfferOrDiscountManager>();
    final prefs = context.use<PrefsService>();
    final bookingManager = context.use<BookingManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as OfferOrDiscountArgs;
      locator<OfferOrDiscountManager>()
          .execute(offerOrDiscountId: args!.offerOrDiscountId);
      locator<OfferOrDiscountManager>().counterSubject.sink.add(1);

    }

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.red,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: AlsurrahAppBar(
            showNotification: false,
            showBack: true,
            showSearch: true,
            title: "${args?.offerOrDiscountTitle}",
          ),
          // ),
        ),
        body: Observer<OfferOrDiscountResponse>(
            stream: offerOrDiscountManager.offerOrDiscountDetails$,
            onRetryClicked: () {
              offerOrDiscountManager.execute(
                  offerOrDiscountId: args!.offerOrDiscountId);
            },
            onSuccess: (context, offerOrDiscountSnapshot) {
              return

                ValueListenableBuilder<ShowZoomable>(
                    valueListenable:
                    offerOrDiscountManager.showZoomableNotifier,
                    builder: (context, value, _) {
                      return Stack(
                        children: [
                          StreamBuilder<ManagerState>(
                              initialData: ManagerState.idle,
                              stream: bookingManager.state$,
                              builder: (context,
                                  AsyncSnapshot<ManagerState> stateSnapshot) {
                                return FormsStateHandling(
                                  managerState: stateSnapshot.data,
                                  errorMsg: bookingManager.errorDescription,
                                  onClickCloseErrorBtn: () {
                                    bookingManager.inState.add(ManagerState.idle);
                                  },
                                child: ListView(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        selectedImage = '${offerOrDiscountSnapshot.data!.discount!.image}';
                                        offerOrDiscountManager.showZoomable =
                                            ShowZoomable.show;
                                      },
                                      child: NetworkAppImage(
                                        height: 300.h,
                                        width: double.infinity,
                                        boxFit: BoxFit.fill,
                                        imageUrl:
                                        '${offerOrDiscountSnapshot.data!.discount!.image}',
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
                                            '${offerOrDiscountSnapshot.data!.discount?.name}',
                                            style: AppFontStyle.biggerBlueLabel,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'التاريخ : ${offerOrDiscountSnapshot.data!.discount?.date}',
                                            style: AppFontStyle.descFont.copyWith(
                                                fontWeight: FontWeight.normal, fontSize: 13),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${offerOrDiscountSnapshot.data?.discount?.price}',
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
                                                '${offerOrDiscountSnapshot.data?.discount?.oldPrice}',
                                                style: AppFontStyle.darkGreyLabel.copyWith(
                                                  color: Colors.black.withOpacity(.6),
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Text(
                                          //   '${offerOrDiscountSnapshot.data!.discount?.price}',
                                          //   style: AppFontStyle.darkGreyLabel,
                                          // ),
                                          const Divider(
                                            height: 30,
                                          ),
                                          Text(
                                            'المدة : ${offerOrDiscountSnapshot.data!.discount?.duration}',
                                            style: AppFontStyle.descFont.copyWith(
                                                fontWeight: FontWeight.normal, fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'العنوان : ${offerOrDiscountSnapshot.data!.discount?.address}',
                                            style: AppFontStyle.descFont.copyWith(
                                                fontWeight: FontWeight.normal, fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'الشروط : ${offerOrDiscountSnapshot.data!.discount?.conditions}',
                                            style: AppFontStyle.descFont.copyWith(
                                                fontWeight: FontWeight.normal, fontSize: 12),
                                          ),
                                          Html(
                                            data:
                                            '${offerOrDiscountSnapshot.data!.discount?.desc}',
                                          ),
                                          if (offerOrDiscountSnapshot.data!.discount?.card ==
                                              "yes")
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15),
                                              child: Text("رقم كارت العائلة : ${prefs.userObj?.box}",style: AppFontStyle.descFont.copyWith(color: AppStyle.darkOrange.withOpacity(.5)),),
                                            ),

                                            // Padding(
                                            //   padding: const EdgeInsets.only(top: 15),
                                            //   child: Theme(
                                            //     data: ThemeData(
                                            //       primaryColor: Colors.redAccent,
                                            //       primaryColorDark: Colors.red,
                                            //     ),
                                            //     child: TextField(
                                            //       controller: _familyCardTextEditing,
                                            //       decoration: const InputDecoration(
                                            //         contentPadding: EdgeInsets.all(8),
                                            //         border: OutlineInputBorder(
                                            //             borderSide: BorderSide(
                                            //               color: AppStyle.darkOrange,
                                            //             )),
                                            //         hintText: 'رقم كارت العائلة',
                                            //         helperText:
                                            //         'برجاء ادخال رقم كارت العائلة لاستكمال الحجز',
                                            //         labelText: 'كارت العائلة',
                                            //         prefixIcon: Icon(
                                            //           Icons.people,
                                            //           color: AppStyle.darkOrange,
                                            //         ),
                                            //         prefixText: ' ',
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            Column(
                                            children: [
                                              const SizedBox(
                                                height: 35,
                                              ),
                                              offerOrDiscountSnapshot.data!.discount!.count == 0 ?  Center(child: Text("الحجز غير متاح",style: AppFontStyle.descFont,)) :    CounterWidget(
                                                stream: offerOrDiscountManager.selectedCount$,
                                                maxCount:  offerOrDiscountSnapshot.data!.discount!.count!,

                                                onDecrement: () {
                                                  offerOrDiscountManager.counterSubject.sink.add(
                                                      offerOrDiscountManager.counterSubject.value - 1);
                                                },
                                                onIncrement: () {
                                                  offerOrDiscountManager.counterSubject.sink.add(
                                                      offerOrDiscountManager.counterSubject.value + 1);
                                                },
                                              ),
                                              const SizedBox(
                                                height: 35,
                                              ),
                                            ],
                                          ),

                                          Center(
                                              child: MainButtonWidget(
                                                  title: "حجز",
                                                  onClick: offerOrDiscountSnapshot.data!.discount!.count == 0 ? null : () {
                                                    // if (offerOrDiscountSnapshot
                                                    //     .data!.discount?.card ==
                                                    //     "yes" &&
                                                    //     _familyCardTextEditing.text.isEmpty) {
                                                    //   locator<ToastTemplate>()
                                                    //       .show("برجاء ادخال رقم كارت العائلة");
                                                    // }
                                                    if (prefs.userObj !=
                                                        null) {
                                                      bookingManager.booking(
                                                          request:
                                                          BookingRequest(
                                                            id: args!.offerOrDiscountId,
                                                            cardId: offerOrDiscountSnapshot.data?.discount?.card != 'no' ? prefs.userObj?.box : '',
                                                            count:  offerOrDiscountManager.counterSubject.value,
                                                            // date: HotelOrChaletManager.getFormattedDate(hotelOrChaletManager.selectedDate),
                                                            // optionId: offerOrDiscountManager.optionNotifier.value,
                                                            time: '',
                                                            type: BookingType.discount.name,
                                                          ));
                                                    } else {
                                                      locator<ToastTemplate>()
                                                          .show(
                                                          "برجاء تسجيل الدخول اولا");
                                                    }
                                                  },
                                                  width: MediaQuery.of(context).size.width * .85))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
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
                                        offerOrDiscountManager.showZoomable =
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
      ),
    );
  }
}
