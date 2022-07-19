import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/ads/ads_page.dart';
import 'package:alsurrah/features/app_settings/app_settings_repo.dart';
import 'package:alsurrah/features/app_settings/app_settings_response.dart';
import 'package:rxdart/rxdart.dart';

class AppSettingsManager extends Manager<AppSettingsResponse> {

  String profitText = "";

  final PublishSubject<AppSettingsResponse> _subject =
      PublishSubject<AppSettingsResponse>();
  Stream<AppSettingsResponse> get settings$ => _subject.stream;

  AppSettingsManager() {
    refreshSettings();
  }

  final prefs = locator<PrefsService>();

  void refreshSettings() {
    Stream.fromFuture(AppSettingsRepo.appSettings()).listen((result) {

      if (result.error == null) {
        profitText = "${result.data!.profitsText}";

        if (result.data?.setting?.fixing != 'no') {
          locator<NavigationService>()
              .pushReplacementNamedTo(AppRoutesNames.fixPage);
          return;
        }
        if (!prefs.hasIntroSeen) {
          locator<NavigationService>()
              .pushReplacementNamedTo(AppRoutesNames.introPage);
          return;
        }
        if (result.data?.setting?.ads == 1) {
          locator<NavigationService>().pushReplacementNamedTo(
              AppRoutesNames.adsPage,
              arguments: AdsArgs(ads: result.data?.ads));
          return;
        }
        // locator<NavigationService>()
        //     .pushReplacementNamedTo(AppRoutesNames.TABS_WIDGET);
        locator<NavigationService>()
            .pushReplacementNamedTo(AppRoutesNames.mainTabsWidget);
        _subject.add(result);
        return;
      } else {
        if (!prefs.hasIntroSeen) {
          locator<NavigationService>()
              .pushReplacementNamedTo(AppRoutesNames.introPage);
          return;
        }

        locator<NavigationService>()
            .pushReplacementNamedTo(AppRoutesNames.mainTabsWidget);
        _subject.add(result);
        _subject.addError(result.error);

        return;
      }
    });
    // return _subject.stream;
  }

  @override
  void dispose() {}

  // late AnimationController innerController;
  // late AnimationController outerController;
}
