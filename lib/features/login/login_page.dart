import 'package:animate_do/animate_do.dart';
import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/login/login_manager.dart';
import 'package:alsurrah/features/login/login_request.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:alsurrah/shared/text_field_obsecure/text_field_obsecure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final passwordFocus = FocusNode();

  final phoneFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final loginManager = context.use<LoginManager>();

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
            showBack: false,
            showSearch: false,
            title: "تسجيل الدخول",
          ),
          // ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.idle,
            stream: loginManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: loginManager.errorDescription,
                onClickCloseErrorBtn: () {
                  loginManager.inState.add(ManagerState.idle);
                },
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        Column(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "تسجيل الدخول",
                                            style:
                                                AppFontStyle.hugDarkGreyLabel,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "مرحبًا بك من فضلك ادخل البريد الالكتروني وكلمة المرور",
                                            style: AppFontStyle.darkGreyLabel
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    FadeInLeftBig(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "رقم الهاتف",
                                            style: AppFontStyle.darkGreyLabel,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextFiled(
                                            currentFocus: phoneFocus,
                                            controller: _phoneController,
                                            // obscureText: obscureText,
                                            keyboardType: TextInputType.phone,
                                            hintText: 'رقم الهاتف',
                                            maxLines: 1,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(passwordFocus);
                                            },
                                            validationBool: (v) {
                                              return (v.length < 8);
                                            },
                                            validationErrorMessage:
                                                'يجب ان لا يقل عدد الارقام عن 8',
                                          ),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            "كلمة المرور",
                                            style: AppFontStyle.darkGreyLabel,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextFiledObscureText(
                                            currentFocus: passwordFocus,
                                            controller: _passwordController,
                                            // obscureText: obscureText,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            hintText: '*********',
                                            // prefixIcon: Padding(
                                            //   padding: const EdgeInsets.all(15.0),
                                            //   child: SvgPicture.asset(
                                            //     AppAssets.lock,
                                            //     // color: Colors.brown,
                                            //     height: 15,
                                            //   ),
                                            // ),
                                            maxLines: 1,
                                            onFieldSubmitted: (v) {
                                              removeFocus(context);
                                            },
                                            validationBool: (v) {
                                              return (v.length < 3);
                                            },
                                            validationErrorMessage:
                                                'يجب ان لا يقل عدد الاحرف عن ٣',
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                AppRoutesNames
                                                    .forgotPasswordPage,
                                              );
                                            },
                                            child: Text(
                                              "نسيت كلمة المرور ؟",
                                              style: AppFontStyle.blueLabel
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                AppRoutesNames.mainTabsWidget,
                                              );
                                            },
                                            child: Text(
                                              "الدخول كزائر",
                                              style: AppFontStyle.darkGreyLabel
                                                  .copyWith(
                                                  decoration:
                                                  TextDecoration.underline,
                                                  fontSize: 12),
                                            ),
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
                        )
                      ],
                    )),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(15),
                      child: FadeInRightBig(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutesNames.registerPage,
                                    );
                                  },
                                  child: Text(
                                    "انشاء حساب جديد ",
                                    style: AppFontStyle.blueLabel,
                                  ),
                                ),
                                Text(
                                  " ليس لديك حساب؟",
                                  style: AppFontStyle.darkGreyLabel,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MainButtonWidget(
                              title: 'تسجيل دخول',
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
                                await loginManager.login(
                                  request: LoginRequest(
                                    phone: _phoneController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                            ),
                          ],
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
