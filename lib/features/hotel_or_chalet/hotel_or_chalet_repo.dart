import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_response.dart';
import 'package:dio/dio.dart';

class HotelOrChaletRepo {
  static Future<HotelOrChaletResponse> hotelOrChalet(
      {required int hotelOrChaletId}) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            // '${locator<ApiService>().dioClient.options.baseUrl}hotel/1',
            '${locator<ApiService>().dioClient.options.baseUrl}hotel/$hotelOrChaletId',
          );

      return HotelOrChaletResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return HotelOrChaletResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        print('xXx xc ${error.error}');
        return HotelOrChaletResponse.makeError(
            error: error,
            errorMsg: locator<PrefsService>().appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        print('xXx xc ${error.error}');
        String errorDescription = locator<PrefsService>().appLanguage == 'en'
            ? 'Something Went Wrong Try Again Later'
            : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

        return HotelOrChaletResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
