import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:flutter/foundation.dart';

class IntroData {
  final String imagePath, title, desc;
  final VoidCallback onClickSkip;

  IntroData({
    required this.imagePath,
    required this.title,
    required this.desc,
    required this.onClickSkip,
  });

  static final List<IntroData> intros = [
    IntroData(
      imagePath: AppAssets.intro_1b,
      title: 'تابع العروض والخصومات',
      desc: "الآن يمكنك متابعة جميع عروض وخصومات جمعية السرة التعاونية",
      onClickSkip: () {},
    ),
    IntroData(
      imagePath: AppAssets.intro_2bPng,
      title: 'احجز الملاعب والفاعليات',
      desc:
          " الآن يمكنك حجز ملعبك المفضل و حجز جميع الأنشطة والفاعليات",
      onClickSkip: () {},
    ),
    IntroData(
      imagePath:AppAssets.intro_3bPng,
      title: 'تابع أخبار جمعية السرة',
      desc:
          " تابع جميع أخبار وأنشطة الجمعية  كما يمكنك متابعة أرباح المساهمين للجمعية",
      onClickSkip: () {},
    ),
  ];
}
