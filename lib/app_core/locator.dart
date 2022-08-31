import 'package:alsurrah/app_core/fcm/FcmTokenManager.dart';
import 'package:alsurrah/app_core/fcm/localNotificationService.dart';
import 'package:alsurrah/app_core/fcm/pushNotification_service.dart';
import 'package:alsurrah/features/account_details/account_details_manager.dart';
import 'package:alsurrah/features/activities/activities_manager.dart';
import 'package:alsurrah/features/activities_details/activities_details_manager.dart';
import 'package:alsurrah/features/app_settings/app_settings_manager.dart';
import 'package:alsurrah/features/barcode/barcode_manager.dart';
import 'package:alsurrah/features/booking/booking_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/home_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/playgrounds/playgrounds_manager.dart';
import 'package:alsurrah/features/branches/branches_manager.dart';
import 'package:alsurrah/features/check_box_agreement/check_box_agreement_manager.dart';
import 'package:alsurrah/features/contact_us/contact_us_manager.dart';
import 'package:alsurrah/features/course_details/course_details_manager.dart';
import 'package:alsurrah/features/courses/courses_manager.dart';
import 'package:alsurrah/features/faq/faq_manager.dart';
import 'package:alsurrah/features/festival_details/festival_details_manager.dart';
import 'package:alsurrah/features/festivals/festivals_manager.dart';
import 'package:alsurrah/features/forgot_password/forgot_password_manager.dart';
import 'package:alsurrah/features/gallery/gallery_manager.dart';
import 'package:alsurrah/features/gallery_details/gallery_details_manager.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_manager.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_manager.dart';
import 'package:alsurrah/features/login/login_manager.dart';
import 'package:alsurrah/features/management/management_manager.dart';
import 'package:alsurrah/features/news/news_manager.dart';
import 'package:alsurrah/features/news_details/news_details_manager.dart';
import 'package:alsurrah/features/notifications/notifications_manager.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_manager.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_manager.dart';
import 'package:alsurrah/features/pages/pages_manager.dart';
import 'package:alsurrah/features/playground_details/playground_details_manager.dart';
import 'package:alsurrah/features/profits/profits_manager.dart';
import 'package:alsurrah/features/register/register_manager.dart';
import 'package:alsurrah/features/report_product/report_product_manager.dart';
import 'package:alsurrah/features/search/search_manager.dart';
import 'package:alsurrah/features/settings_page/settings_manager.dart';
import 'package:get_it/get_it.dart';

import 'app_core.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance!);

  /// AppLanguageManager
  locator.registerLazySingleton<AppLanguageManager>(() => AppLanguageManager());

  /// NavigationService
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  /// ToastTemplate
  locator.registerLazySingleton<ToastTemplate>(() => ToastTemplate());

  /// ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());

  /// NewsManager
  locator.registerLazySingleton<NewsManager>(() => NewsManager());

  /// HomeManager
  locator.registerLazySingleton<HomeManager>(() => HomeManager());

  /// NewsDetailsManager
  locator.registerLazySingleton<NewsDetailsManager>(() => NewsDetailsManager());

  /// ActivitiesManager
  locator.registerLazySingleton<ActivitiesManager>(() => ActivitiesManager());

  /// ActivityDetailsManager
  locator.registerLazySingleton<ActivityDetailsManager>(
      () => ActivityDetailsManager());

  /// ManagementManager
  locator.registerLazySingleton<ManagementManager>(() => ManagementManager());

  /// FestivalsManager
  locator.registerLazySingleton<FestivalsManager>(() => FestivalsManager());

  /// FestivalDetailsManager
  locator.registerLazySingleton<FestivalDetailsManager>(
      () => FestivalDetailsManager());

  /// CoursesManager
  locator.registerLazySingleton<CoursesManager>(() => CoursesManager());

  /// CourseDetailsManager
  locator.registerLazySingleton<CourseDetailsManager>(
      () => CourseDetailsManager());

  /// OffersAndDiscountsManager
  locator.registerLazySingleton<OffersAndDiscountsManager>(
      () => OffersAndDiscountsManager());

  /// OfferOrDiscountManager
  locator.registerLazySingleton<OfferOrDiscountManager>(
      () => OfferOrDiscountManager());

  /// HotelAndChaletsManager
  locator.registerLazySingleton<HotelAndChaletsManager>(
      () => HotelAndChaletsManager());

  /// HotelOrChaletManager
  locator.registerLazySingleton<HotelOrChaletManager>(
      () => HotelOrChaletManager());

  /// PlaygroundsManager
  locator.registerLazySingleton<PlaygroundsManager>(() => PlaygroundsManager());

  /// PlaygroundDetailsManager
  locator.registerLazySingleton<PlaygroundDetailsManager>(
      () => PlaygroundDetailsManager());

  /// LoginManager
  locator.registerLazySingleton<LoginManager>(() => LoginManager());

  /// RegisterManager
  locator.registerLazySingleton<RegisterManager>(() => RegisterManager());

  /// GalleryManager
  locator.registerLazySingleton<GalleryManager>(() => GalleryManager());

  /// GalleryDetailsManager
  locator.registerLazySingleton<GalleryDetailsManager>(
      () => GalleryDetailsManager());

  /// ReportProductManager
  locator.registerLazySingleton<ReportProductManager>(
      () => ReportProductManager());

  /// AccountDetailsManager
  locator.registerLazySingleton<AccountDetailsManager>(
      () => AccountDetailsManager());

  /// BarcodeManager
  locator.registerLazySingleton<BarcodeManager>(() => BarcodeManager());

  /// BranchesManager
  locator.registerLazySingleton<BranchesManager>(() => BranchesManager());

  /// PagesManager
  locator.registerLazySingleton<PagesManager>(() => PagesManager());

  /// FAQManager
  locator.registerLazySingleton<FAQManager>(() => FAQManager());

  /// ContactUsManager
  locator.registerLazySingleton<ContactUsManager>(() => ContactUsManager());

  /// SettingsManager
  locator.registerLazySingleton<SettingsManager>(() => SettingsManager());

  /// AppSettingsManager
  locator.registerLazySingleton<AppSettingsManager>(() => AppSettingsManager());

  /// FcmTokenManager
  locator.registerLazySingleton<FcmTokenManager>(() => FcmTokenManager());

  /// LocalNotificationService
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  /// PushNotificationService
  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());

  /// NotificationsManager
  locator.registerLazySingleton<NotificationsManager>(
      () => NotificationsManager());

  /// FamilyCartManager
  locator.registerLazySingleton<FamilyCartManager>(() => FamilyCartManager());

  /// SearchManager
  locator.registerLazySingleton<SearchManager>(() => SearchManager());

  /// ForgotPasswordManager
  locator.registerLazySingleton<ForgotPasswordManager>(
      () => ForgotPasswordManager());

  /// ProfitsManager
  locator.registerLazySingleton<ProfitsManager>(() => ProfitsManager());

  /// CheckBoxManager
  locator.registerLazySingleton<CheckBoxManager>(() => CheckBoxManager());

  /// BookingManager
  locator.registerLazySingleton<BookingManager>(() => BookingManager());
}
