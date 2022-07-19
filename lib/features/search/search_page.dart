import 'dart:developer';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/search/search_manager.dart';
import 'package:alsurrah/features/search/search_response.dart';
import 'package:alsurrah/shared/custom_text_field/custom_text_field.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:alsurrah/shared/remove_focus/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  late final SearchManager searchManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      searchManager = context.use<SearchManager>();
      searchManager.wordController.clear();
      searchManager.resetManager();
      searchManager.reCallManager();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // searchManager = context.use<SearchManager>();

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
            showSearch: false,
            title: "البحث",
          ),
          // ),
        ),
        body: SafeArea(
          top: false,
          child: Observer<SearchResponse>(
              onRetryClicked: searchManager.reCallManager,
              stream: searchManager.response$,
              onSuccess: (context, searchSnapshot) {
                searchManager.updateSearchList(
                    totalItemsCount: searchSnapshot.data?.info?.total ?? 0,
                    snapshotSearch: searchSnapshot.data?.products ?? []);
                return Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      controller: searchManager.scrollController,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFiled(
                                controller: searchManager.wordController,
                                // keyboardType: TextInputType.text,
                                hintText: 'ابحث',
                                maxLines: 1,
                                onFieldSubmitted: (v) {
                                  removeFocus(context);
                                },
                                validationBool: (v) {
                                  return (v.length < 1);
                                },
                                validationErrorMessage:
                                    'لا يمكن ان يترك هذا الحقل فارغا',
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                log("loglogloglog ${searchManager.wordController.text}");
                                searchManager.resetManager();
                                searchManager.reCallManager();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppStyle.darkOrange,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.search,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        searchManager.searchList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchManager.searchList.length,
                                itemBuilder: (_, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: Card(
                                    elevation: 2.0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      side: BorderSide(
                                          width: 0.1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${searchManager.searchList[index].code}",
                                            style: AppFontStyle.descFont
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: AppStyle.mediumGrey
                                                        .withOpacity(.9)),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "${searchManager.searchList[index].name}",
                                            style: AppFontStyle.descFont
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: AppStyle.mediumGrey
                                                        .withOpacity(.9)),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "${searchManager.searchList[index].price}",
                                            style: AppFontStyle.descFont
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: AppStyle.mediumGrey
                                                        .withOpacity(.9)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 150.h,
                                  ),
                                  NotAvailableComponent(
                                    view: const FaIcon(
                                      FontAwesomeIcons.magnifyingGlassMinus,
                                      color: AppStyle.darkOrange,
                                      size: 100,
                                    ),
                                    title: 'لا توجد نتائج متاحة',
                                    titleTextStyle: AppFontStyle.biggerBlueLabel
                                        .copyWith(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w900),
                                    // ('no News'),
                                  ),
                                ],
                              ),
                        StreamBuilder<PaginationState>(
                            initialData: PaginationState.idle,
                            stream: searchManager.paginationState$,
                            builder: (context, paginationStateSnapshot) {
                              if (paginationStateSnapshot.data ==
                                  PaginationState.loading) {
                                return const ListTile(
                                    title: Center(
                                  child: SpinKitWave(
                                    color: AppStyle.darkOrange,
                                    itemCount: 5,
                                    size: 30.0,
                                  ),
                                ));
                              }
                              if (paginationStateSnapshot.data ==
                                  PaginationState.error) {
                                return ListTile(
                                  leading: const Icon(Icons.error),
                                  title: Text(
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'Something Went Wrong Try Again Later'
                                        : 'حدث خطأ ما حاول مرة أخرى لاحقاً',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () async {
                                      await searchManager.onErrorLoadMore();
                                    },
                                    child: Text(
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'Retry'
                                            : 'أعد المحاولة'),
                                  ),
                                );
                              }
                              return const SizedBox(
                                width: 0,
                                height: 0,
                              );
                            }),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
