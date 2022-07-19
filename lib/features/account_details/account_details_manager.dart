import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/account_details/account_details_repo.dart';
import 'package:alsurrah/features/account_details/account_details_response.dart';
import 'package:alsurrah/features/account_details/account_request.dart';
import 'package:alsurrah/features/login/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AccountDetailsManager extends Manager<AuthResponse> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController boxController = TextEditingController();

  String? errorDescription;
  final _prefs = locator<PrefsService>();

  final PublishSubject<ManagerState> _stateSubject = PublishSubject();
  final AccountDetailsRepo _accountDetailsRepo = AccountDetailsRepo();

  Stream<ManagerState> get state$ => _stateSubject.stream;
  Sink<ManagerState> get inState => _stateSubject.sink;

  Future<ManagerState> editProfile({required AccountRequest request}) async {
    var managerState = ManagerState.loading;
    inState.add(ManagerState.loading);
    await _accountDetailsRepo.updateAccount(request).then((result) {
      if (result.status == 1) {
        inState.add(ManagerState.success);
        _prefs.userObj = result.user;

        locator<ToastTemplate>().show("${result.message}");
        locator<NavigationService>().goBack();

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

  final BehaviorSubject<AccountDetailsResponse> _subject =
      BehaviorSubject<AccountDetailsResponse>();
  Stream<AccountDetailsResponse> get accountDetails$ => _subject.stream;

  execute() {
    Stream.fromFuture(AccountDetailsRepo.accountDetails()).listen((result) {
      if (result.error == null) {
        nameController =
            TextEditingController(text: "${result.data!.user!.name}");
        print("XXXXXXXXXXXXXXXXXX ${result.data!.user!.name}");
        phoneController =
            TextEditingController(text: "${result.data!.user!.phone}");
        emailController =
            TextEditingController(text: "${result.data!.user!.email}");
        boxController =
            TextEditingController(text: "${result.data!.user!.box}");
        _subject.sink.add(result);
      } else {
        _subject.sink.addError(result.error);
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    // _stateSubject.close();
  }
}
