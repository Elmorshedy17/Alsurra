import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/gallery/gallery_manager.dart';
import 'package:alsurrah/features/gallery/gallery_response.dart';
import 'package:alsurrah/features/gallery/widgets/gallery_item.dart';
import 'package:alsurrah/features/gallery_details/gallery_details_page.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late final GalleryManager galleryManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      galleryManager = context.use<GalleryManager>();
      galleryManager.resetManager();
      galleryManager.reCallManager();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "ألبوم الصور",
        ),
        // ),
      ),
      body: SafeArea(
        top: false,
        child: Observer<GalleryResponse>(
            onRetryClicked: galleryManager.reCallManager,
            stream: galleryManager.response$,
            onSuccess: (context, gallerySnapshot) {
              galleryManager.updateGalleryList(
                  totalItemsCount: gallerySnapshot.data?.info?.total ?? 0,
                  snapshotGallery: gallerySnapshot.data?.gallery ?? []);
              return ListView(
                controller: galleryManager.scrollController,
                children: [
                  galleryManager.galleryList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 15, right: 15, left: 15),
                          itemCount: galleryManager.galleryList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.9,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (_, index) => GalleryItem(
                            imageUrl: galleryManager.galleryList[index].image!,
                            // imageUrl:
                            //     'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/rivet-emerly-media-console-1610578756.jpg?crop=1xw:1xh;center,top&resize=768:*',
                            title: galleryManager.galleryList[index].name!,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutesNames.galleryDetailsPage,
                                arguments: GalleryDetailsArgs(
                                    galleryId:
                                        galleryManager.galleryList[index].id!,
                                    galleryTitle:
                                        galleryManager.galleryList[index].name),
                              );
                            },
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 150.h,
                            ),
                            NotAvailableComponent(
                              view: const FaIcon(
                                FontAwesomeIcons.squarePollHorizontal,
                                color: AppStyle.darkOrange,
                                size: 100,
                              ),
                              title: 'لا توجد ألبومات متاحة',
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
                      stream: galleryManager.paginationState$,
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
                                await galleryManager.onErrorLoadMore();
                              },
                              child: Text(
                                  locator<PrefsService>().appLanguage == 'en'
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
              );
            }),
      ),
    );
  }
}
