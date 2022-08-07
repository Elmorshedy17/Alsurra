import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/festival_details/festival_details_manager.dart';
import 'package:alsurrah/features/festival_details/festival_details_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rxdart/rxdart.dart';

class FestivalDetailsArgs {
  final int festivalId;
  final String? festivalTitle;

  FestivalDetailsArgs({required this.festivalId, this.festivalTitle});
}

class FestivalDetailsPage extends StatefulWidget {
  const FestivalDetailsPage({Key? key}) : super(key: key);

  @override
  State<FestivalDetailsPage> createState() => _FestivalDetailsPageState();
}

class _FestivalDetailsPageState extends State<FestivalDetailsPage> {
  final BehaviorSubject<int> _indicatorSubject = BehaviorSubject<int>.seeded(0);
  Stream<int> get indicatorIndex$ => _indicatorSubject.stream;
  Sink<int> get inIndicatorIndex => _indicatorSubject.sink;
  String selectedImage = '';

  FestivalDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as FestivalDetailsArgs;
      if (args != null) {
        locator<FestivalDetailsManager>().execute(festivalId: args!.festivalId);
      }
      // context.use<FestivalDetailsManager>().execute(FestivalId: args!.FestivalId);
    });
    locator<FestivalDetailsManager>().showZoomable =
        ShowZoomable.hide;
  }

  @override
  Widget build(BuildContext context) {
    final festivalDetailsManager = context.use<FestivalDetailsManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as FestivalDetailsArgs;
      locator<FestivalDetailsManager>().execute(festivalId: args!.festivalId);
    }

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "${args?.festivalTitle}",
        ),
        // ),
      ),
      body: Observer<FestivalDetailsResponse>(
          stream: festivalDetailsManager.festivalDetails$,
          onRetryClicked: () {
            festivalDetailsManager.execute(festivalId: args!.festivalId);
          },
          onSuccess: (context, festivalDetailsSnapshot) {
            return

              ValueListenableBuilder<ShowZoomable>(
                  valueListenable:
                  festivalDetailsManager.showZoomableNotifier,
                  builder: (context, value, _) {
                    return Stack(
                      children: [
                        ListView(
                          children: [

                            SizedBox(
                              height: 300.h,
                              width: double.infinity,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  // autoPlay: widget.sliderList!.length > 1,
                                    autoPlay: festivalDetailsSnapshot.data!.offer!.images!.length > 1,
                                    enlargeCenterPage: false,
                                    aspectRatio: 2,
                                    viewportFraction: 1,
                                    disableCenter: true,
                                    onPageChanged: (index, reason) {
                                      inIndicatorIndex.add(index);
                                    }),
                                // items: widget.sliderList!
                                items: festivalDetailsSnapshot.data!.offer!.images!
                                    .map(
                                      (e) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    // child: Card(
                                    //     elevation: widget.isCard ? 4.0 : 0.0,
                                    // shape: const RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.all(
                                    //     Radius.circular(10.0),
                                    //   ),
                                    // ),
                                    child: Container(
                                      padding:const EdgeInsets.all(0.0),
                                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: ClipRRect(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(20)),
                                        // const BorderRadius.all(Radius.circular(0)),
                                        child: InkWell(
                                          onTap: () {
                                                selectedImage = e;
                                                festivalDetailsManager.showZoomable =
                                                    ShowZoomable.show;
                                          },
                                          child: NetworkAppImage(
                                            boxFit: BoxFit.fill,
                                            // imageUrl: '${e.image}',
                                            imageUrl: e,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ),

                            // InkWell(
                            //   onTap: (){
                            //     selectedImage = '${festivalDetailsSnapshot.data!.offer!.image}';
                            //     festivalDetailsManager.showZoomable =
                            //         ShowZoomable.show;
                            //   },
                            //   child: NetworkAppImage(
                            //     height: 300.h,
                            //     width: double.infinity,
                            //     boxFit: BoxFit.fill,
                            //     imageUrl: '${festivalDetailsSnapshot.data!.offer!.image}',
                            //     // imageUrl: '${e}',
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    '${festivalDetailsSnapshot.data!.offer?.name}',
                                    style: AppFontStyle.biggerBlueLabel,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'تاريخ البدء : ${festivalDetailsSnapshot.data!.offer?.startDate}',
                                    style: AppFontStyle.descFont,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'تاريخ الانتهاء : ${festivalDetailsSnapshot.data!.offer?.endDate}',
                                    style: AppFontStyle.descFont,
                                  ),
                                  Html(
                                    data: '${festivalDetailsSnapshot.data!.offer?.desc}',
                                  ),
                                ],
                              ),
                            )
                          ],
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
                                      festivalDetailsManager.showZoomable =
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
                  });
          }),
    );
  }
}
