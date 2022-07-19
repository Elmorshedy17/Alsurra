import 'package:animate_do/animate_do.dart';
import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/report_product/report_product_manager.dart';
import 'package:alsurrah/features/report_product/report_product_request.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportProductPage extends StatefulWidget {
  const ReportProductPage({Key? key}) : super(key: key);

  @override
  State<ReportProductPage> createState() => _ReportProductPageState();
}

class _ReportProductPageState extends State<ReportProductPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _productNameController = TextEditingController();

  final TextEditingController _branchController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  final nameFocus = FocusNode();

  final phoneFocus = FocusNode();

  final productNameFocus = FocusNode();

  final branchFocus = FocusNode();

  final descFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final reportProductManager = context.use<ReportProductManager>();

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
            title: "بلغ عن سلعة",
          ),
          // ),
        ),
        body: StreamBuilder<ManagerState>(
            initialData: ManagerState.idle,
            stream: reportProductManager.state$,
            builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
              return FormsStateHandling(
                managerState: stateSnapshot.data,
                errorMsg: reportProductManager.errorDescription,
                onClickCloseErrorBtn: () {
                  reportProductManager.inState.add(ManagerState.idle);
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
                                    FadeInLeftBig(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                            // obscureText: obscureText,
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
                                            height: 35,
                                          ),
                                          Text(
                                            "التليفون",
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
                                            hintText: 'التليفون',
                                            maxLines: 1,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      productNameFocus);
                                            },
                                            validationBool: (v) {
                                              return (v.length < 8);
                                            },
                                            validationErrorMessage:
                                                'يجب ان لا يقل عدد الارقام عن ٨',
                                          ),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            "اسم السلعة",
                                            style: AppFontStyle.darkGreyLabel,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextFiled(
                                            currentFocus: productNameFocus,
                                            controller: _productNameController,
                                            // obscureText: obscureText,
                                            keyboardType: TextInputType.text,
                                            hintText: "اسم السلعة",
                                            maxLines: 1,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(branchFocus);
                                            },
                                            validationBool: (v) {
                                              return (v.length < 3);
                                            },
                                            validationErrorMessage:
                                                'يجب ان لا يقل عدد الاحرف عن ٣',
                                          ),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            "الفرع",
                                            style: AppFontStyle.darkGreyLabel,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextFiled(
                                            currentFocus: branchFocus,
                                            controller: _branchController,
                                            // obscureText: obscureText,
                                            keyboardType: TextInputType.text,
                                            hintText: "الفرع",
                                            maxLines: 1,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(descFocus);
                                            },
                                            validationBool: (v) {
                                              return (v.length < 3);
                                            },
                                            validationErrorMessage:
                                                'يجب ان لا يقل عدد الاحرف عن ٣',
                                          ),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            "الوصف",
                                            style: AppFontStyle.darkGreyLabel,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextFiled(
                                            currentFocus: descFocus,
                                            controller: _descController,
                                            isTextArea: true,
                                            keyboardType: TextInputType.text,
                                            hintText: "الوصف",
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
                            MainButtonWidget(
                              title: 'تبليغ',
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

                                await reportProductManager.reportProduct(
                                  request: ReportProductRequest(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      message: _descController.text,
                                      branch: _branchController.text,
                                      product: _productNameController.text),
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
