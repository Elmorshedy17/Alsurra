import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/features/booking/booking_payment/booking_web_view.dart';
import 'package:alsurrah/features/booking/booking_repo.dart';
import 'package:alsurrah/features/booking/booking_request.dart';
import 'package:alsurrah/features/booking/booking_response.dart';
import 'package:rxdart/rxdart.dart';

class BookingManager extends Manager<BookingResponse> {
  final BookingRepo _bookingRepo = BookingRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;
  final navigationService = locator<NavigationService>();

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> booking({required BookingRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _bookingRepo.booking(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        navigationService.pushNamedTo(
          AppRoutesNames.bookingWebViewPage,
          arguments: BookingWebViewArgs(paymentUrl: '${result.data?.url}'),
        );
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
