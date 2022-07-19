import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_manager.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final _familyCardTextEditing = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    final offerOrDiscountManager = context.use<OfferOrDiscountManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as OfferOrDiscountArgs;
      locator<OfferOrDiscountManager>()
          .execute(offerOrDiscountId: args!.offerOrDiscountId);
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
              return ListView(
                children: [
                  NetworkAppImage(
                    height: 200.h,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    imageUrl:
                    '${offerOrDiscountSnapshot.data!.discount!.image}',
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
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.redAccent,
                                primaryColorDark: Colors.red,
                              ),
                              child: TextField(
                                controller: _familyCardTextEditing,
                                decoration:const  InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppStyle.darkOrange,
                                      )),
                                  hintText: 'رقم كارت العائلة',
                                  helperText:
                                  'برجاء ادخال رقم كارت العائلة لاستكمال الحجز',
                                  labelText: 'كارت العائلة',
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: AppStyle.darkOrange,
                                  ),
                                  prefixText: ' ',
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                            child: MainButtonWidget(
                                title: "حجز",
                                onClick: () {
                                  if (offerOrDiscountSnapshot
                                      .data!.discount?.card ==
                                      "yes" &&
                                      _familyCardTextEditing.text.isEmpty) {
                                    locator<ToastTemplate>()
                                        .show("برجاء ادخال رقم كارت العائلة");
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
