import 'package:animate_do/animate_do.dart';
import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/forgot_password/forgot_password_manager.dart';
import 'package:alsurrah/features/forgot_password/forgot_password_request.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordManager = context.use<ForgotPasswordManager>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: const AlsurrahAppBar(
            showNotification: false,
            showBack: true,
            showSearch: false,
            title: "نسيت كلمة المرور",
          ),
          // ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.idle,
            stream: forgotPasswordManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: forgotPasswordManager.errorDescription,
                onClickCloseErrorBtn: () {
                  forgotPasswordManager.inState.add(ManagerState.idle);
                },
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        Form(
                          key: _formKey,
                          autovalidateMode: _autoValidateMode,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                FadeInRightBig(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          AppAssets.lockPng,
                                          height: 120.h,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 45,
                                      ),
                                      Text(
                                        "نسيت كلمة المرور؟",
                                        style: AppFontStyle.darkGreyLabel
                                            .copyWith(
                                          fontSize: 20.sp,
                                            color: Colors.black,
                                            // fontWeight: FontWeight.normal,
                                            height: 1.6),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "من فضلك أدخل عنوان بريدك الإلكتروني و سنرسل لك بريدًا إلكترونيًا يحتوي على الإرشادات حول كيفية تغيير كلمة المرور الخاصة بك",
                                        style: AppFontStyle.darkGreyLabel
                                            .copyWith(
                                                fontWeight: FontWeight.normal,
                                                height: 1.6),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                FadeInLeftBig(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "البريد الالكتروني",
                                        style: AppFontStyle.darkGreyLabel,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomTextFiled(
                                        controller: _emailController,
                                        keyboardType: TextInputType.text,
                                        hintText: 'البريد الالكتروني',
                                        maxLines: 1,
                                        onFieldSubmitted: (v) {
                                          removeFocus(context);
                                        },
                                        validationBool: (v) {
                                          if (v.isEmpty) {
                                            return true;
                                          } else {
                                            if (EmailValidator.validate(v)) {
                                              return false;
                                            } else {
                                              return true;
                                            }
                                          }
                                        },
                                        validationErrorMessage:
                                            'يرجى ادخال بريد الكتروني صحيح',
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: FadeInRightBig(
                        child: MainButtonWidget(
                          title: 'ارسل كلمة المرور',
                          onClick: () async {

                            removeFocus(context);
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            } else {
                              setState(() {
                                _autoValidateMode = AutovalidateMode.always;
                              });
                              return;
                            }

                            await forgotPasswordManager.forgotPassword(
                                request: ForgotPasswordRequest(
                                  email: _emailController.text,
                                ),
                                thenDo: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) {
                                        return Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: Container(
                                            // width: 50,
                                            padding: const EdgeInsets.all(35.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Image.asset(
                                                  AppAssets.mailKey,
                                                  height: 120.h,
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                  "لقد أرسلنا رابط إعادة تعيين كلمة المرور إلى عنوان البريد الإلكتروني ",
                                                  style: AppFontStyle
                                                      .darkGreyLabel
                                                      .copyWith(height: 1.6),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  child: MainButtonWidget(
                                                      title: "تاكيد",
                                                      onClick: () {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                          AppRoutesNames
                                                              .loginPage,
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
