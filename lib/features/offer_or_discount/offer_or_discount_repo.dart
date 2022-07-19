import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_response.dart';
import 'package:dio/dio.dart';

class OfferOrDiscountRepo {
  static Future<OfferOrDiscountResponse> offerOrDiscount(
      {required int offerOrDiscountId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}discount/$offerOrDiscountId',
          );

      return OfferOrDiscountResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return OfferOrDiscountResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return OfferOrDiscountResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return OfferOrDiscountResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
