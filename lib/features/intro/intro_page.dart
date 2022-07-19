import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/intro/intro_data.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  // late int _length;
  // final ValueNotifier<int> pageIndex = ValueNotifier(0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    prefs.hasIntroSeen = true;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0,
        backgroundColor: Colors.black87,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarColor: Colors.black87,
        //     statusBarBrightness: Brightness.light,
        //     systemStatusBarContrastEnforced: true),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: -26.h,
            left: 90.w,
            right: 0,
            // bottom: 0,
            child: SvgPicture.asset(
              AppAssets.introBottom,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          PageView.builder(
            allowImplicitScrolling: true,
            reverse: false,
            onPageChanged: (index) {
              // pageIndex.value = index;
              setState(() {
                currentIndex = index;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            // physics: const BouncingScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: IntroData.intros.length,
            itemBuilder: (_, index) => SafeArea(
              top: false,
              // bottom: false,
              // child: SingleChildScrollView(
              //   physics: const NeverScrollableScrollPhysics(),
              child: Container(
                // height: MediaQuery.of(context).size.height - 43.h,
                // color: AppStyle.darkOrange,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    // Positioned(
                    //   top: 50,
                    //   left: 0,
                    //   right: 0,
                    //   // bottom: 0,
                    //   child: SvgPicture.asset(
                    //     index == 0
                    //         ? AppAssets.intro_1b
                    //         : index == 1
                    //             ? AppAssets.intro_2bPng
                    //             : AppAssets.intro_3bPng,
                    //     width: MediaQuery.of(context).size.width,
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                    Positioned(
                      top: index == 0 ? 50 : 0,
                      left: 50,
                      right: 50,
                      // bottom: 0,
                      child: index == 0 ? SvgPicture.asset(
                        IntroData.intros[index].imagePath,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ) : Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Image.asset(
                          IntroData.intros[index].imagePath,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.30,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   gradient: LinearGradient(
                        //     begin: FractionalOffset.topCenter,
                        //     end: FractionalOffset.bottomCenter,
                        //     colors: [
                        //       Colors.grey.withOpacity(0.0),
                        //       Colors.black,
                        //     ],
                        //     stops: const [0.0, 1.0],
                        //   ),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 120.h,
                              ),
                              Text(
                                IntroData.intros[index].title,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Text(
                                IntroData.intros[index].desc,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black.withOpacity(.4),
                                  height: 1.3,
                                ),
                                // textAlign: TextAlign.center,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 50.w,
            right: 50.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if (currentIndex > 0)
                //   InkWell(
                //     onTap: () {
                //       if (currentIndex > 0) {
                //         _pageController.animateToPage(currentIndex - 1,
                //             duration: const Duration(milliseconds: 1000),
                //             curve: Curves.easeOut);
                //       }
                //     },
                //     child: Container(
                //       padding: const EdgeInsets.all(8),
                //       decoration: BoxDecoration(
                //         color: Colors.black,
                //         borderRadius: BorderRadius.circular(100),
                //       ),
                //       child: Icon(
                //         Icons.arrow_back,
                //         color: Colors.white,
                //         size: 18.sp,
                //       ),
                //     ),
                //   ),
                // Expanded(
                //   child:
                SizedBox(
                  height: 10.sp,
                  child: Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        // itemCount: widget.sliderList!.length,
                        itemCount: IntroData.intros.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppStyle.darkOrange
                                  : Colors.white,
                              // : AppStyle.orange.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: AppStyle.darkOrange),
                            ),
                            // height: 4,
                            width: 10.sp,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            // padding: EdgeInsets.symmetric(horizontal: 5),
                          );
                        }),
                  ),
                ),
                // ),
                // InkWell(
                //   onTap: () {
                //     if (currentIndex < IntroData.intros.length - 1) {
                //       _pageController.animateToPage(currentIndex + 1,
                //           duration: const Duration(milliseconds: 1000),
                //           curve: Curves.easeOut);
                //     } else {
                //       Navigator.of(context)
                //           .pushReplacementNamed(AppRoutesNames.loginPage);
                //     }
                //   },
                //   child: currentIndex != IntroData.intros.length - 1
                //       ? Container(
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.black,
                //             borderRadius: BorderRadius.circular(100),
                //           ),
                //           child: Icon(
                //             Icons.arrow_forward,
                //             color: Colors.white,
                //             size: 18.sp,
                //           ),
                //         )
                //       : Text(
                //           'ابدأ',
                //           style:
                //               TextStyle(color: Colors.white, fontSize: 16.sp),
                //         ),
                // ),
                SizedBox(
                  height: 30,
                ),
                MainButtonWidget(
                  title: currentIndex < IntroData.intros.length - 1
                      ? 'التالي'
                      : 'ابدأ الآن',
                  onClick: () {
                    if (currentIndex < IntroData.intros.length - 1) {
                      _pageController.animateToPage(currentIndex + 1,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOut);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutesNames.loginPage);
                    }
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutesNames.loginPage);
                    },
                    child: Text(
                      'تخطي',
                      style: TextStyle(color: AppStyle.darkOrange),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
