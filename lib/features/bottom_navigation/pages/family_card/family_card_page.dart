import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FamilyCardPage extends StatefulWidget {
  const FamilyCardPage({Key? key}) : super(key: key);

  @override
  State<FamilyCardPage> createState() => _FamilyCardPageState();
}

class _FamilyCardPageState extends State<FamilyCardPage> {
  final TextEditingController _familyCardController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {

    final familyCartManager = context.use<FamilyCartManager>();

    if(locator<PrefsService>().userObj != null){
      familyCartManager.execute();
    }

    return  locator<PrefsService>().userObj == null ? InkWell(
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
      desc: familyCartManager.errorDescription??"",
      // desc: "اضغط هنا لتسجيل الدخول",
      view:const FaIcon(
        FontAwesomeIcons.bug,
        color: AppStyle.darkOrange,
        size: 100,
      ),

    );

    // return GestureDetector(
    //   onTap: () {
    //     removeFocus(context);
    //   },
    //   child: StreamBuilder<ManagerState>(
    //       initialData: ManagerState.idle,
    //       stream: familyCartManager.state$,
    //       builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
    //         return FormsStateHandling(
    //           managerState: stateSnapshot.data,
    //           errorMsg: familyCartManager.errorDescription,
    //           onClickCloseErrorBtn: () {
    //             familyCartManager.inState.add(ManagerState.idle);
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.all(15.0),
    //             child: Form(
    //               key: _formKey,
    //               autovalidateMode: _autoValidateMode,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //
    //                   if(locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.card == "")
    //                     CustomTextFiled(
    //                       controller: _familyCardController,
    //                       keyboardType: TextInputType.text,
    //                       hintText: 'بطاقة العائلة',
    //                       maxLines: 1,
    //                       onFieldSubmitted: (v) {
    //                         removeFocus(context);
    //                       },
    //                       validationBool: (v) {
    //                         return (v.length < 1);
    //                       },
    //                       validationErrorMessage:
    //                       'لا يمكن ان يترك هذا الحقل فارغا',
    //                     ),
    //
    //                   if(locator<PrefsService>().userObj != null && locator<PrefsService>().userObj!.card != "")
    //                     Text("رقم الصندوق الخاص بك هو ${locator<PrefsService>().userObj!.card}"),
    //                   const SizedBox(
    //                     height: 25,
    //                   ),
    //                   Center(
    //                     child: MainButtonWidget(
    //                       title: (locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.card == "") ? "بحث" : "عرض",
    //                       width: 150,
    //                       onClick: () async {
    //                         removeFocus(context);
    //                         if(locator<PrefsService>().userObj == null || locator<PrefsService>().userObj!.card == ""){
    //                           if (_formKey.currentState!.validate()) {
    //                             _formKey.currentState!.save();
    //                           } else {
    //                             setState(() {
    //                               _autoValidateMode = AutovalidateMode.always;
    //                             });
    //                             return;
    //                           }
    //                         }
    //
    //                         await familyCartManager.familyCart(
    //                           request: FamilyCartRequest(
    //                               cardId: locator<PrefsService>().userObj == null ? _familyCardController.text : locator<PrefsService>().userObj!.card != "" ? locator<PrefsService>().userObj!.card : _familyCardController.text),
    //                           // cardId: "740",)
    //                         );
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       }),
    // );
  }
}