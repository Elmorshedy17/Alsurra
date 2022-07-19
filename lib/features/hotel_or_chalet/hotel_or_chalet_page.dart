import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_manager.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_response.dart';
import 'package:alsurrah/features/hotel_or_chalet/widgets/select_date.dart';
import 'package:alsurrah/shared/check_box/check_box.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotelOrChaletArgs {
  final int hotelOrChaletId;
  final String? hotelOrChaletTitle;

  HotelOrChaletArgs({required this.hotelOrChaletId, this.hotelOrChaletTitle});
}

class HotelOrChaletPage extends StatefulWidget {
  const HotelOrChaletPage({Key? key}) : super(key: key);

  @override
  State<HotelOrChaletPage> createState() => _HotelOrChaletPageState();
}

class _HotelOrChaletPageState extends State<HotelOrChaletPage> {
  HotelOrChaletArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as HotelOrChaletArgs;
      if (args != null) {
        locator<HotelOrChaletManager>()
            .execute(hotelOrChaletId: args!.hotelOrChaletId);
      }
      locator<HotelOrChaletManager>().resetDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotelOrChaletManager = context.use<HotelOrChaletManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as HotelOrChaletArgs;
      locator<HotelOrChaletManager>()
          .execute(hotelOrChaletId: args!.hotelOrChaletId);
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
            title: "${args?.hotelOrChaletTitle}",
          ),
          // ),
        ),
        body: Observer<HotelOrChaletResponse>(
            stream: hotelOrChaletManager.hotelOrChaletDetails$,
            onRetryClicked: () {
              hotelOrChaletManager.execute(
                  hotelOrChaletId: args!.hotelOrChaletId);
            },
            onSuccess: (context, hotelOrChaletSnapshot) {
              return ListView(
                children: [
                  NetworkAppImage(
                    height: 200.h,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    imageUrl: '${hotelOrChaletSnapshot.data!.hotel!.image}',
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
                          '${hotelOrChaletSnapshot.data!.hotel?.name}',
                          style: AppFontStyle.biggerBlueLabel,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'التاريخ : ${hotelOrChaletSnapshot.data!.hotel?.date}',
                          style: AppFontStyle.descFont.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 13),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '${hotelOrChaletSnapshot.data?.hotel?.price}',
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
                              '${hotelOrChaletSnapshot.data?.hotel?.oldPrice}',
                              style: AppFontStyle.darkGreyLabel.copyWith(
                                color: Colors.black.withOpacity(.6),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   '${hotelOrChaletSnapshot.data!.hotel?.price}',
                        //   style: AppFontStyle.darkGreyLabel,
                        // ),
                        const Divider(
                          height: 30,
                        ),
                        Html(
                          data: '${hotelOrChaletSnapshot.data!.hotel?.desc}',
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (hotelOrChaletSnapshot
                            .data!.hotel!.options!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppStyle.darkGrey.withOpacity(.3),
                              ),
                            ),
                            child: ValueListenableBuilder<int>(
                                valueListenable:
                                hotelOrChaletManager.optionNotifier,
                                builder: (context, value, _) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount: hotelOrChaletSnapshot
                                        .data!.hotel!.options!.length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 25,
                                        color:
                                        AppStyle.darkGrey.withOpacity(.6),
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      Options option = hotelOrChaletSnapshot
                                          .data!.hotel!.options![index];

                                      return InkWell(
                                        onTap: () {
                                          hotelOrChaletManager
                                              .optionNotifier.value =
                                          hotelOrChaletSnapshot.data!.hotel!
                                              .options![index].id!;
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomCheckBox(
                                                isChecked: option.id ==
                                                    hotelOrChaletManager
                                                        .optionNotifier.value),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${option.name}",
                                                  style: AppFontStyle.blueLabel,
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  "${option.price}",
                                                  style: AppFontStyle
                                                      .darkGreyLabel,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        DateTimeWidget(),
                        const SizedBox(
                          height: 35,
                        ),

                        Center(
                            child: MainButtonWidget(
                                title: "حجز",
                                onClick: (){
                                  if(hotelOrChaletManager.optionNotifier.value == 0 ){
                                    locator<ToastTemplate>().show("برجاء تحديد الاختيار اولا");
                                  }else{

                                  }
                                },
                                width: MediaQuery.of(context).size.width * .85))

                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}