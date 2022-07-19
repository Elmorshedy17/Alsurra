import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_manager.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_page.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_manager.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_page.dart';
import 'package:flutter/material.dart';

class FixedSection {
  final String image, title;
  final Color backgroundColor;
  final VoidCallback onClick;

  const FixedSection({
    required this.image,
    required this.title,
    required this.backgroundColor,
    required this.onClick,
  });

  static List<FixedSection> homeSections = [
    FixedSection(
      title: 'ألبوم الصور',
      image: AppAssets.home_0,
      backgroundColor: const Color(0xff25559F),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.galleryPage);
      },
    ),
    FixedSection(
      title: 'أخبار رئيسية',
      image: AppAssets.home_1,
      backgroundColor: const Color(0xff4578C5),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.newsPage);
      },
    ),
    FixedSection(
      title: 'مهرجانات وعروض',
      backgroundColor: const Color(0xffF5D833),
      image: AppAssets.home_2,
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.festivalsPage);
      },
    ),
    FixedSection(
      title: 'أرباح المساهمين',
      image: AppAssets.home_3,
      backgroundColor: const Color(0xffF19F52),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.profitsPage);
      },
    ),
    FixedSection(
      title: 'بلغ عن سلعة',
      image: AppAssets.home_4,
      backgroundColor: const Color(0xffD0E773),
      onClick: () {
        locator<NavigationService>()
            .pushNamedTo(AppRoutesNames.reportProductPage);
      },
    ),
    FixedSection(
      title: 'قارئ الباركود',
      image: AppAssets.home_5,
      backgroundColor: const Color(0xffEA760E),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.barcodePage);
      },
    ),
    FixedSection(
      title: 'تواصل معنا',
      image: AppAssets.home_6,
      backgroundColor: const Color(0xffB0D0F6),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.contactUsPage);
      },
    ),
    FixedSection(
      title: 'مجلس الإدارة',
      image: AppAssets.home_7,
      backgroundColor: const Color(0xffB0D0F6),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.managementPage);
      },
    ),
    FixedSection(
      title: 'الفروع والخدمات',
      image: AppAssets.home_8,
      backgroundColor: const Color(0xff0191AB),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.branchesPage);
      },
    ),
  ];

  /// eventsSections
  static List<FixedSection> eventsSections = [
    FixedSection(
      title: 'العروض',
      image: AppAssets.event_0,
      backgroundColor: const Color(0xffD0E773),
      onClick: () {
        locator<OffersAndDiscountsManager>().type = Type.offer.name;
        locator<NavigationService>().pushNamedTo(
          AppRoutesNames.offersAndDiscountsPage,
          arguments: OffersAndDiscountsArgs(
              type: locator<OffersAndDiscountsManager>().type, title: "العروض"),
        );
      },
    ),
    FixedSection(
      title: 'اﻷنشطة',
      image: AppAssets.event_1,
      backgroundColor: const Color(0xff305EA4),
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.activitiesPage);
      },
    ),
    FixedSection(
      title: 'الدورات',
      backgroundColor: const Color(0xffEA760E),
      image: AppAssets.event_2,
      onClick: () {
        locator<NavigationService>().pushNamedTo(AppRoutesNames.coursesPage);
      },
    ),
    FixedSection(
      title: 'الشاليهات',
      image: AppAssets.event_3,
      backgroundColor: const Color(0xffF19F52),
      onClick: () {
        locator<HotelAndChaletsManager>().type = TypeHotelChalet.chalet.name;
        locator<NavigationService>().pushNamedTo(
          AppRoutesNames.hotelAndChaletsPage,
          arguments: HotelAndChaletsArgs(
              type: locator<HotelAndChaletsManager>().type, title: "الشاليهات"),
        );
      },
    ),
    FixedSection(
      title: 'الخصومات',
      image: AppAssets.event_4,
      backgroundColor: const Color(0xffF5D833),
      onClick: () {
        locator<OffersAndDiscountsManager>().type = Type.discount.name;
        locator<NavigationService>().pushNamedTo(
          AppRoutesNames.offersAndDiscountsPage,
          arguments: OffersAndDiscountsArgs(
              type: locator<OffersAndDiscountsManager>().type,
              title: "الخصومات"),
        );
      },
    ),
    FixedSection(
      title: 'الفنادق',
      image: AppAssets.event_5,
      backgroundColor: const Color(0xff0191AB),
      onClick: () {
        locator<HotelAndChaletsManager>().type = TypeHotelChalet.hotel.name;
        locator<NavigationService>().pushNamedTo(
          AppRoutesNames.hotelAndChaletsPage,
          arguments: HotelAndChaletsArgs(
              type: locator<HotelAndChaletsManager>().type, title: "الفنادق"),
        );
      },
    ),
  ];
}
