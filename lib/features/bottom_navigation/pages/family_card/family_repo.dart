import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_response.dart';
import 'package:dio/dio.dart';

class FamilyCartRepo {
  final prefs = locator<PrefsService>();

  Future<FamilyCartResponse> familyCart(FamilyCartRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}profits',
            data: formData,
          );
      return FamilyCartResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return FamilyCartResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return FamilyCartResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return FamilyCartResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
