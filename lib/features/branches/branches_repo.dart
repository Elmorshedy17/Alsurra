import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/branches/branches_response.dart';
import 'package:dio/dio.dart';

class BranchesRepo {
  static Future<BranchesResponse> branches() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}branches',
          );

      return BranchesResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return BranchesResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return BranchesResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return BranchesResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
