import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/forgot_password/forgot_password_repo.dart';
import 'package:alsurrah/features/forgot_password/forgot_password_request.dart';
import 'package:alsurrah/features/login/auth_response.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordManager extends Manager<AuthResponse> {
  final ForgotPasswordRepo _forgotPasswordRepo = ForgotPasswordRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> forgotPassword(
      {required ForgotPasswordRequest request, required thenDo}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _forgotPasswordRepo.forgotPassword(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);

        thenDo();
        // locator<NavigationService>().goBack();

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
