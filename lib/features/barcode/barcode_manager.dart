import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/barcode/barcode_repo.dart';
import 'package:alsurrah/features/barcode/barcode_request.dart';
import 'package:alsurrah/features/barcode/barcode_response.dart';
import 'package:rxdart/rxdart.dart';

class BarcodeManager extends Manager<BarcodeResponse> {
  final BarcodeRepo _barcodeRepo = BarcodeRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;
  String? message;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> barcode({required BarcodeRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _barcodeRepo.barcode(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        message = result.message;

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
}
