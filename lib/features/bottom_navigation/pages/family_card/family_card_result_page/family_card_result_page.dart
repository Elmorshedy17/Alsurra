import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FamilyCardResultsPageArgs {
  final FamilyCartResponse? familyCartResponse;

  FamilyCardResultsPageArgs({required this.familyCartResponse});
}

class FamilyCardResultsPage extends StatefulWidget {
  const FamilyCardResultsPage({Key? key}) : super(key: key);

  @override
  State<FamilyCardResultsPage> createState() => _FamilyCardResultsPageState();
}

class _FamilyCardResultsPageState extends State<FamilyCardResultsPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as FamilyCardResultsPageArgs;

     return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil( AppRoutesNames.mainTabsWidget, (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child:  AlsurrahAppBar(
            showNotification: false,
            onClickBack: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil( AppRoutesNames.mainTabsWidget, (Route<dynamic> route) => false);
            },
            showBack: true,
            showSearch: true,
            title: "بطاقة العائلة",
          ),
          // ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Image.asset(
                    "${AppAssets.familyCardCard}",
                    height: MediaQuery.of(context).size.height * .3,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: const EdgeInsets.all(40),
                    height: MediaQuery.of(context).size.height * .3,
                    // width: MediaQuery.of(context).size.width /2,
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "${args.familyCartResponse!.data!.card!.id}",
                                style: AppFontStyle.whiteLabel.copyWith(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(.9)),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                "${args.familyCartResponse!.data!.card!.name}",
                                style: AppFontStyle.whiteLabel.copyWith(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(.9)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "بيانات كارت العائلة",
                style: AppFontStyle.hugDarkGreyLabel.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppStyle.lightGrey),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: args.familyCartResponse!.data!.card!.users!.length,
                    itemBuilder: (_, index) {
                      String usersList =
                          args.familyCartResponse!.data!.card!.users![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Text(
                          usersList,
                          style: AppFontStyle.descFont,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 150.h,
                child: NetworkAppImage(
                  imageUrl: "${args.familyCartResponse!.data!.card!.qrCode}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
