import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/account_details/account_details_response.dart';
import 'package:alsurrah/features/account_details/account_request.dart';
import 'package:alsurrah/features/login/auth_response.dart';
import 'package:dio/dio.dart';

class AccountDetailsRepo {
  final prefs = locator<PrefsService>();

  static Future<AccountDetailsResponse> accountDetails() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}profile',
          );

      return AccountDetailsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return AccountDetailsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return AccountDetailsResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return AccountDetailsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }

  Future<AuthResponse> updateAccount(AccountRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}profile',
            data: formData,
          );
      return AuthResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return AuthResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return AuthResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return AuthResponse.makeError(error: error, errorMsg: errorDescription);
      }
    }
  }
}
