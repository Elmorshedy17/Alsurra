import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/contact_us/RegisterRequest.dart';
import 'package:alsurrah/features/contact_us/contact_us_response.dart';
import 'package:dio/dio.dart';

class ContactUsRepo {
  static Future<GetContactUsInfoResponse> contactUs() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}contact',
          );

      return GetContactUsInfoResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return GetContactUsInfoResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return GetContactUsInfoResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return GetContactUsInfoResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }

  final prefs = locator<PrefsService>();

  Future<GetContactUsInfoResponse> contactUsPost(
      ContactUsRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}contact',
            data: formData,
          );
      return GetContactUsInfoResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return GetContactUsInfoResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return GetContactUsInfoResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return GetContactUsInfoResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
