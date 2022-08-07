import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/gallery/widgets/gallery_item.dart';
import 'package:alsurrah/features/gallery_details/gallery_details_manager.dart';
import 'package:alsurrah/features/gallery_details/gallery_details_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class GalleryDetailsArgs {
  final int galleryId;
  final String? galleryTitle;

  GalleryDetailsArgs({required this.galleryId, this.galleryTitle});
}

class GalleryDetailsPage extends StatefulWidget {
  const GalleryDetailsPage({Key? key}) : super(key: key);

  @override
  State<GalleryDetailsPage> createState() => _GalleryDetailsPageState();
}

class _GalleryDetailsPageState extends State<GalleryDetailsPage> {
  String selectedImage = '';
  GalleryDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as GalleryDetailsArgs;
      if (args != null) {
        locator<GalleryDetailsManager>().execute(galleryId: args!.galleryId);
      }
      // context.use<NewsDetailsManager>().execute(newsId: args!.newsId);
    });
    locator<GalleryDetailsManager>().showZoomable =
        ShowZoomable.hide;
  }

  @override
  Widget build(BuildContext context) {
    final galleryDetailsManager = context.use<GalleryDetailsManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as GalleryDetailsArgs;
      galleryDetailsManager.execute(galleryId: args!.galleryId);
    }

    return WillPopScope(
      onWillPop: () async {
        galleryDetailsManager.showZoomable = ShowZoomable.hide;

        return true;
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
            title: "${args?.galleryTitle}",
            onClickBack: () {
              galleryDetailsManager.showZoomable = ShowZoomable.hide;
              Navigator.of(context).pop();
            },
            onClickSearch: () {
              galleryDetailsManager.showZoomable = ShowZoomable.hide;
            },
          ),
        ),
        body: Observer<GalleryDetailsResponse>(
            stream: galleryDetailsManager.galleryDetails$,
            onRetryClicked: () {
              galleryDetailsManager.execute(galleryId: args!.galleryId);
            },
            onSuccess: (context, galleryDetailsSnapshot) {
              return galleryDetailsSnapshot.data!.gallery!.images!.isNotEmpty
                  ? ValueListenableBuilder<ShowZoomable>(
                      valueListenable:
                          galleryDetailsManager.showZoomableNotifier,
                      builder: (context, value, _) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: GridView.builder(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    top: 24, bottom: 15, right: 15, left: 15),
                                itemCount: galleryDetailsSnapshot
                                    .data!.gallery!.images!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 1.1,
                                        crossAxisSpacing: 7,
                                        mainAxisSpacing: 7),
                                itemBuilder: (_, index) => GalleryItem(
                                  imageUrl: galleryDetailsSnapshot
                                      .data!.gallery!.images![index],
                                  // imageUrl:
                                  //     'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/rivet-emerly-media-console-1610578756.jpg?crop=1xw:1xh;center,top&resize=768:*',

                                  onTap: () {
                                    selectedImage = galleryDetailsSnapshot
                                        .data!.gallery!.images![index];
                                    galleryDetailsManager.showZoomable =
                                        ShowZoomable.show;
                                  },
                                ),
                              ),
                            ),
                            if (value == ShowZoomable.show)
                              Positioned.fill(
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: PhotoView(
                                        backgroundDecoration:
                                        const BoxDecoration(
                                            color: Colors.black38),
                                        minScale: PhotoViewComputedScale.contained * 0.3,
                                        initialScale: PhotoViewComputedScale.contained * 0.8,
                                        imageProvider: NetworkImage(
                                            selectedImage,
                                            scale: 1
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      left: 30,
                                      child: FloatingActionButton(
                                        // mini: true,
                                        onPressed: () {
                                          galleryDetailsManager.showZoomable =
                                              ShowZoomable.hide;
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      })
                  : Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        NotAvailableComponent(
                          view: const FaIcon(
                            FontAwesomeIcons.photoFilm,
                            color: AppStyle.darkOrange,
                            size: 100,
                          ),
                          title: 'ألبوم فارغ',
                          titleTextStyle: AppFontStyle.biggerBlueLabel.copyWith(
                              fontSize: 18.sp, fontWeight: FontWeight.w900),
                          // ('no News'),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
