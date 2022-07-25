import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/app_settings/app_settings_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:alsurrah/features/profits/profits_manager.dart';
import 'package:alsurrah/features/profits/profits_request.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfitsPage extends StatefulWidget {
  const ProfitsPage({Key? key}) : super(key: key);

  @override
  State<ProfitsPage> createState() => _ProfitsPageState();
}

class _ProfitsPageState extends State<ProfitsPage> {
  final TextEditingController _familyCardController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final profitsManager = context.use<ProfitsManager>();

    if(locator<PrefsService>().userObj != null){
      profitsManager.execute();
    }



    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            // child: SafeArea(
            child:const AlsurrahAppBar(
              showNotification: false,
              showBack: true,
              showSearch: false,
              title: "ارباح الماهمين",
            ),
            // ),
          ),
          body: locator<PrefsService>().userObj == null ? InkWell(
            onTap:(){
              Navigator.of(context)
                  .pushNamed(AppRoutesNames.loginPage);
            },
            child: NotAvailableComponent(
              title: "برجاء تسجيل الدخول اولا",
              desc: "اضغط هنا لتسجيل الدخول",
              view: Column(
                children: const [
                  FaIcon(
                    FontAwesomeIcons.doorOpen,
                    color: AppStyle.darkOrange,
                    size: 100,
                  ),
                ],
              ),

            ),
          ):NotAvailableComponent(
            desc: profitsManager.errorDescription??"",
            // desc: "اضغط هنا لتسجيل الدخول",
            view:const FaIcon(
              FontAwesomeIcons.bug,
              color: AppStyle.darkOrange,
              size: 100,
            ),

          )
//         StreamBuilder<ManagerState>(
//             initialData: ManagerState.idle,
//             stream: profitsManager.state$,
//             builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
//               return FormsStateHandling(
//                 managerState: stateSnapshot.data,
//                 errorMsg: profitsManager.errorDescription,
//                 onClickCloseErrorBtn: () {
//                   profitsManager.inState.add(ManagerState.idle);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Form(
//                     key: _formKey,
//                     autovalidateMode: _autoValidateMode,
//                     child: Center(
//                       child: ListView(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
// const SizedBox(
//   height: 25,
// ),
//
//                         Center(
//                           child: SvgPicture.asset(
//                               AppAssets.home_6,height: 75.h,fit: BoxFit.fill,
//                             color: AppStyle.blue,
//                             ),
//                         ),
//                           // Center(child: Image.asset(,)),
//                            SizedBox(
//                             height: MediaQuery.of(context).size.height * .1,
//                           ),
//
//                           Text("للاستعلام عن الأرباح , يرجى ادخال رقم الصندوق",style: AppFontStyle.descFont,textAlign: TextAlign.center,),
//                           const SizedBox(
//                             height: 15,
//                           ),
//
//                           if(locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.box == "")
//                           CustomTextFiled(
//                             controller: _familyCardController,
//                             keyboardType: TextInputType.text,
//                             hintText: 'رقم الصندوق',
//                             maxLines: 1,
//                             onFieldSubmitted: (v) {
//                               removeFocus(context);
//                             },
//                             validationBool: (v) {
//                               return (v.length < 1);
//                             },
//                             validationErrorMessage:
//                                 'لا يمكن ان يترك هذا الحقل فارغا',
//                           ),
//
//                           if(locator<PrefsService>().userObj != null && locator<PrefsService>().userObj!.box != "")
//                             Text("رقم الصندوق الخاص بك هو ${locator<PrefsService>().userObj!.box}"),
//                              SizedBox(
//                             height: MediaQuery.of(context).size.height * .2,
//                           ),
//
//
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SvgPicture.asset(
//                                 AppAssets.info,
//                                 color: Colors.red,
//                                 // height: 8,
//                               ),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               Expanded(child: Text(locator<AppSettingsManager>().profitText,style: AppFontStyle.descFont,)),
//                             ],
//                           ),
//
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           Center(
//                             child: MainButtonWidget(
//                               title: (locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.box == "") ? "بحث" : "عرض",
//                               // width: 150,
//                               onClick: () async {
//                                 removeFocus(context);
//                                 if(locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.box == "" ){
//                                   if (_formKey.currentState!.validate()) {
//                                     _formKey.currentState!.save();
//                                   } else {
//                                     setState(() {
//                                       _autoValidateMode = AutovalidateMode.always;
//                                     });
//                                     return;
//                                   }
//                                 }
//
//                                 await profitsManager.profits(
//                                   request: ProfitsRequest(
//                                       cardId: locator<PrefsService>().userObj != null ? locator<PrefsService>().userObj!.box == "" ?  _familyCardController.text  : locator<PrefsService>().userObj!.box: _familyCardController.text),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
      ),
    );
  }
}
