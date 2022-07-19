import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_request.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_response.dart';
import 'package:alsurrah/features/profits/profits_request.dart';
import 'package:alsurrah/features/profits/profits_response.dart';
import 'package:dio/dio.dart';

class ProfitsRepo {
  final prefs = locator<PrefsService>();

  Future<ProfitsResponse> profits(ProfitsRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}profits',
            data: formData,
          );
      return ProfitsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return ProfitsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return ProfitsResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return ProfitsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
