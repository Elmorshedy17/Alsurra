import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/app_core/services/url_launcher/url_launcher.dart';
import 'package:alsurrah/features/contact_us/RegisterRequest.dart';
import 'package:alsurrah/features/contact_us/contact_us_manager.dart';
import 'package:alsurrah/features/contact_us/contact_us_response.dart';
import 'package:alsurrah/features/contact_us/widgets/map_widget.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final nameFocus = FocusNode();

  final emailFocus = FocusNode();

  final messageFocus = FocusNode();

  final phoneFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<ContactUsManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactUsManager = context.use<ContactUsManager>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: const AlsurrahAppBar(
            showNotification: false,
            showBack: true,
            showSearch: true,
            title: "تواصل معنا",
          ),
          // ),
        ),
        body: Observer<GetContactUsInfoResponse>(
            stream: contactUsManager.contactUs$,
            onRetryClicked: () {
              context.use<ContactUsManager>().execute();
            },
            onSuccess: (context, contactUsInfoSnapshot) {
              return StreamBuilder<ManagerState>(
                  initialData: ManagerState.idle,
                  stream: contactUsManager.state$,
                  builder:
                      (context, AsyncSnapshot<ManagerState> stateSnapshot) {
                    return FormsStateHandling(
                      managerState: stateSnapshot.data,
                      errorMsg: contactUsManager.errorDescription,
                      onClickCloseErrorBtn: () {
                        contactUsManager.inState.add(ManagerState.idle);
                      },
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 150.h,
                            child: MapWidget(
                                lat: "${contactUsInfoSnapshot.data!.info!.lat}",
                                lng:
                                    "${contactUsInfoSnapshot.data!.info!.lng}"),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "تواصل معنا",
                                  style: AppFontStyle.darkGreyLabel
                                      .copyWith(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: AppStyle.lightGrey,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (contactUsInfoSnapshot
                                                      .data!.info!.phone !=
                                                  null ||
                                              contactUsInfoSnapshot
                                                      .data!.info!.phone !=
                                                  "") {
                                            openURL(
                                                "tel://${contactUsInfoSnapshot.data!.info!.phone}");
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "رقم الهاتف:",
                                              style: AppFontStyle.darkGreyLabel,
                                            ),
                                            Text(
                                              " ${contactUsInfoSnapshot.data!.info!.phone}",
                                              style: AppFontStyle.darkGreyLabel
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: AppStyle.mediumGrey
                                                          .withOpacity(.7)),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (contactUsInfoSnapshot.data!.info!.lat != null ||
                                              contactUsInfoSnapshot
                                                      .data!.info!.lat !=
                                                  "" ||
                                              contactUsInfoSnapshot
                                                      .data!.info!.lng !=
                                                  null ||
                                              contactUsInfoSnapshot
                                                      .data!.info!.lng !=
                                                  "") {
                                            MapUtils.openMap(
                                                double.parse(
                                                    "${contactUsInfoSnapshot.data!.info!.lat}"),
                                                double.parse(
                                                    "${contactUsInfoSnapshot.data!.info!.lng}"));
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "العنوان:",
                                              style: AppFontStyle.darkGreyLabel,
                                            ),
                                            Text(
                                              " ${contactUsInfoSnapshot.data!.info!.address}",
                                              style: AppFontStyle.darkGreyLabel
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: AppStyle.mediumGrey
                                                          .withOpacity(.7)),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (EmailValidator.validate(
                                              "${contactUsInfoSnapshot.data!.info!.email}")) {
                                            openURL(
                                                "mailto:${contactUsInfoSnapshot.data!.info!.email}");
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "البريد الالكتروني:",
                                              style: AppFontStyle.darkGreyLabel,
                                            ),
                                            Text(
                                              " ${contactUsInfoSnapshot.data!.info!.email}",
                                              style: AppFontStyle.darkGreyLabel
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: AppStyle.mediumGrey
                                                          .withOpacity(.7)),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  autovalidateMode: _autoValidateMode,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        "ارسل رسالة",
                                        style: AppFontStyle.darkGreyLabel
                                            .copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "الاسم",
                                        style: AppFontStyle.darkGreyLabel,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomTextFiled(
                                        currentFocus: nameFocus,
                                        controller: _nameController,
                                        keyboardType: TextInputType.text,
                                        hintText: 'الاسم',
                                        maxLines: 1,
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(phoneFocus);
                                        },
                                        validationBool: (v) {
                                          return (v.length < 3);
                                        },
                                        validationErrorMessage:
                                            'يجب ان لا يقل عدد الاحرف عن ٣',
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
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
                                        keyboardType: TextInputType.phone,
                                        hintText: 'رقم الهاتف',
                                        maxLines: 1,
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(emailFocus);
                                        },
                                        validationBool: (v) {
                                          return (v.length < 8);
                                        },
                                        validationErrorMessage:
                                            'يجب ان لا يقل عدد الارقام عن ٨',
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        "البريد الالكتروني",
                                        style: AppFontStyle.darkGreyLabel,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomTextFiled(
                                        currentFocus: emailFocus,
                                        controller: _emailController,
                                        keyboardType: TextInputType.text,
                                        hintText: 'البريد الالكتروني',
                                        maxLines: 1,
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(messageFocus);
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
                                        height: 25,
                                      ),
                                      Text(
                                        "الرسالة",
                                        style: AppFontStyle.darkGreyLabel,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomTextFiled(
                                        currentFocus: messageFocus,
                                        controller: _messageController,
                                        isTextArea: true,
                                        hintText: 'اكتب رسالتك هنا',
                                        maxLines: 3,
                                        onFieldSubmitted: (v) {
                                          removeFocus(context);
                                        },
                                        validationBool: (v) {
                                          return (v.length < 3);
                                        },
                                        validationErrorMessage:
                                            'يجب ان لا يقل عدد الاحرف عن ٣',
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      MainButtonWidget(
                                        title: 'ارسال',
                                        onClick: () async {
                                          removeFocus(context);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                          } else {
                                            setState(() {
                                              _autoValidateMode =
                                                  AutovalidateMode.always;
                                            });
                                            return;
                                          }

                                          await contactUsManager.contactUsPost(
                                            request: ContactUsRequest(
                                                message:
                                                    _messageController.text,
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phone: _phoneController.text),
                                          );
                                        },
                                      ),


                                      // SizedBox(
                                      //   height: 40,
                                      // ),
                                      // MainButtonWidget(
                                      //   gradientColors: [
                                      //       Color(0xffe5794c),
                                      //       Color(0xffe56c46),
                                      //       Color(0xffe75c40),
                                      //       Color(0xffe8503b),
                                      //       Color(0xffeb4537),
                                      //       Color(0xffeb3f34),
                                      //   ],
                                      //   color: AppStyle.darkOrange,
                                      //   title: "hello",
                                      // ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
