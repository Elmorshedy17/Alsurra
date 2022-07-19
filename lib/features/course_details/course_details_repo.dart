import 'dart:developer';
import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/course_details/course_details_response.dart';
import 'package:dio/dio.dart';

class CourseDetailsRepo {
  static Future<CourseDetailsResponse> courseDetails(
      {required int CourseId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}course/$CourseId',
          );

      return CourseDetailsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return CourseDetailsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        log('xXx xc ${error.error}');
        return CourseDetailsResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        log('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return CourseDetailsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
