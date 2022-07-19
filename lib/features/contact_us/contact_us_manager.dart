import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/contact_us/RegisterRequest.dart';
import 'package:alsurrah/features/contact_us/contact_us_repo.dart';
import 'package:alsurrah/features/contact_us/contact_us_response.dart';
import 'package:rxdart/rxdart.dart';

class ContactUsManager extends Manager<GetContactUsInfoResponse> {
  final BehaviorSubject<GetContactUsInfoResponse> subject =
      BehaviorSubject<GetContactUsInfoResponse>();
  Stream<GetContactUsInfoResponse> get contactUs$ => subject.stream;

  execute() {
    Stream.fromFuture(ContactUsRepo.contactUs()).listen((result) {
      if (result.error == null) {
        subject.sink.add(result);
      } else {
        subject.sink.addError(result.error);
      }
    });
  }

  @override
  void dispose() {}

  final ContactUsRepo _contactUsRepo = ContactUsRepo();
  final _prefs = locator<PrefsService>();
  String? errorDescription;

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> contactUsPost(
      {required ContactUsRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _contactUsRepo.contactUsPost(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);

        if (result.message != null || result.message != "") {
          locator<ToastTemplate>().show("${result.message}");
        }

        locator<NavigationService>().goBack();

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
  void clearSubject() {}
}
