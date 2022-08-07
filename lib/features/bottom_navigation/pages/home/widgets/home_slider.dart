import 'package:carousel_slider/carousel_slider.dart';
import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/app_core/services/url_launcher/url_launcher.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/home_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/home_response.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rxdart/rxdart.dart';

class HomeSlider extends StatefulWidget {
  // final List<SliderAndService>? sliderList;
  final int sliderDuration;
  final bool isCard;
  final double sliderHeight;
  final bool hasUrl;
  const HomeSlider(
      {Key? key,
        this.sliderDuration = 1,
        // this.sliderList,
        this.isCard = true,
        required this.hasUrl,
        this.sliderHeight = 280})
      : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final BehaviorSubject<int> _indicatorSubject = BehaviorSubject<int>.seeded(0);
  Stream<int> get indicatorIndex$ => _indicatorSubject.stream;
  Sink<int> get inIndicatorIndex => _indicatorSubject.sink;
  // List<String> images = [
  //   'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/briget-side-table-1582143245.jpg?crop=1.00xw:0.770xh;0,0.129xh&resize=768:*',
  //   'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/amazon-rivet-furniture-1533048038.jpg?crop=1.00xw:0.502xh;0,0.425xh&resize=980:*',
  //   'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/rivet-emerly-media-console-1610578756.jpg?crop=1xw:1xh;center,top&resize=768:*',
  //   'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/archer-home-designs-dining-table-1594830125.jpg?crop=0.657xw:1.00xh;0.0986xw,0&resize=768:*'
  // ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<HomeManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeManager = context.use<HomeManager>();

    return Observer<HomeResponse>(
        stream: homeManager.home$,
        onRetryClicked: homeManager.execute,
        onWaiting: (_) => const SizedBox.shrink(),
        onError: (_, __) => const SizedBox.shrink(),
        onSuccess: (context, homeSnapshot) {
          return Container(
              child:
              // (widget.sliderList != null)
              //     ?
              Stack(
                children: [
                  SizedBox(
                    height: widget.sliderHeight,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        // autoPlay: widget.sliderList!.length > 1,
                          autoPlay: homeSnapshot.data!.slider!.length > 1,
                          enlargeCenterPage: false,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          disableCenter: true,
                          onPageChanged: (index, reason) {
                            inIndicatorIndex.add(index);
                          }),
                      // items: widget.sliderList!
                      items: homeSnapshot.data!.slider!
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
                            padding: EdgeInsets.all(widget.isCard ? 0.0 : 0.0),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                              // const BorderRadius.all(Radius.circular(0)),
                              child: InkWell(
                                onTap: () {
                                  if (e.link?.isNotEmpty ?? false) {
                                    openURL("${e.link}");
                                  }
                                },
                                child: NetworkAppImage(
                                  boxFit: BoxFit.fill,
                                  // imageUrl: '${e.image}',
                                  imageUrl: '${e.image}',
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
                  Positioned(
                    bottom: 7,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                openURL("https://alsurracoop.com");
                                // http://dahmnstore.com/
                              },
                              child:const Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                  child: Center(
                                    child: Text("اطلب الان"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        StreamBuilder(
                            initialData: 0,
                            stream: indicatorIndex$,
                            builder: (context, indexSnapshot) {
                              return SizedBox(
                                height: 7,
                                child: Center(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // itemCount: widget.sliderList!.length,
                                      itemCount: homeSnapshot.data!.slider!.length > 1
                                          ? homeSnapshot.data!.slider!.length
                                          : 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: indexSnapshot.data == index
                                                ? AppStyle.darkOrange
                                                : AppStyle.darkOrange.withOpacity(0.5),
                                            // : AppStyle.orange.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          // height: 4,
                                          width: indexSnapshot.data == index ? 30 : 12,
                                          margin:
                                          const EdgeInsets.symmetric(horizontal: 3),
                                          // padding: EdgeInsets.symmetric(horizontal: 5),
                                        );
                                      }),
                                ),
                              );
                            }),
                      ],
                    ),
                  )
                ],
              )
            // : Container(),
          );
        });
  }

  @override
  void dispose() {
    // _indicatorSubject.close();
    super.dispose();
  }
}
