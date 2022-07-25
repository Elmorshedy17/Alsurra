import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_card_result_page/family_card_result_page.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_repo.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_response.dart';
import 'package:alsurrah/features/profits/profits_repo.dart';
import 'package:alsurrah/features/profits/profits_request.dart';
import 'package:alsurrah/features/profits/profits_response.dart';
import 'package:alsurrah/features/profits/profits_result_page/profits_result_page.dart';
import 'package:rxdart/rxdart.dart';

class ProfitsManager extends Manager<ProfitsResponse> {
  // ProfitsResponse? profitsResponse;

  final ProfitsRepo _profitsRepo = ProfitsRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;
  final _toast = locator<ToastTemplate>();

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> profits({required ProfitsRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _profitsRepo.profits(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        // profitsResponse = result;
        locator<NavigationService>().pushNamedTo(
            AppRoutesNames.profitsResultsPage,
            arguments: ProfitsResultsPageArgs(profitsResponse: result));

        managerState = ManagerState.success;
      } else if (result.status == 0) {
        inState.add(ManagerState.error);
        errorDescription = result.message??"";
        _toast.show("$errorDescription");

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

  void execute(){
    profits(
      request: ProfitsRequest(
          cardId: "${locator<PrefsService>().userObj!.box}"),
      // cardId: "740",)
    );
  }

  @override
  void dispose() {
    _stateSubject.close();
  }

  @override
  void clearSubject() {}
}
