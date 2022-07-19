import 'dart:developer';
import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_response.dart';
import 'package:dio/dio.dart';

class OffersAndDiscountsRepo {
  static Future<OffersAndDiscountsResponse> offersAndDiscounts(
      {required int pageNum, required String type}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}discounts?type=$type&page=$pageNum',
          );

      return OffersAndDiscountsResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return OffersAndDiscountsResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        log('xXx xc ${error.error}');
        return OffersAndDiscountsResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        log('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return OffersAndDiscountsResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
