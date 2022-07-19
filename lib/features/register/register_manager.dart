import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/login/auth_response.dart';
import 'package:alsurrah/features/register/register_repo.dart';
import 'package:alsurrah/features/register/register_request.dart';
import 'package:rxdart/rxdart.dart';

class RegisterManager extends Manager<AuthResponse> {
  final RegisterRepo _registerRepo = RegisterRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> register({required RegisterRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _registerRepo.register(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        _prefs.userObj = result.user;

        locator<NavigationService>()
            .pushReplacementNamedTo(AppRoutesNames.mainTabsWidget);

        // locator<NavigationService>()
        //     .pushReplacementNamedTo(AppRoutesNames.MainPageWithDrawer);

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
