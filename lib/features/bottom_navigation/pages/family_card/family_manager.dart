import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_card_result_page/family_card_result_page.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_repo.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_response.dart';
import 'package:rxdart/rxdart.dart';

class FamilyCartManager extends Manager<FamilyCartResponse> {
  // FamilyCartResponse? familyCartResponse;

  final FamilyCartRepo _familyCartRepo = FamilyCartRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> familyCart({required FamilyCartRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _familyCartRepo.familyCart(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        // familyCartResponse = result;
        locator<NavigationService>().pushNamedTo(
            AppRoutesNames.familyCardResultsPage,
            arguments: FamilyCardResultsPageArgs(familyCartResponse: result));

        managerState = ManagerState.success;
      } else if (result.status == 0) {
        inState.add(ManagerState.error);
        errorDescription = result.message;
        managerState = ManagerState.error;
      } else if (result.error.error is SocketException) {
        inState.add(ManagerState.socketError);
        errorDescription = _prefs.appLanguage == 'en'
            ? 'No Internet Connection'
            : 'لا يوجد إتصال بالشبكة';
        managerState = ManagerState.socketError;
      } else {
        inState.add(ManagerState.unknownError);
        errorDescription = _prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';
        managerState = ManagerState.unknownError;
      }
    });
    return managerState;
  }

  @override
  void dispose() {
    _stateSubject.close();
  }

  @override
  void clearSubject() {}
}
