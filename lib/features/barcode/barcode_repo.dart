import 'dart:developer';
import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/barcode/barcode_request.dart';
import 'package:alsurrah/features/barcode/barcode_response.dart';
import 'package:dio/dio.dart';

class BarcodeRepo {
  final prefs = locator<PrefsService>();

  Future<BarcodeResponse> barcode(BarcodeRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    log('${formData.fields}');
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}qr_code',
            data: formData,
          );
      return BarcodeResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 422) {
        return BarcodeResponse.fromJsonError(
            json: error.response?.data, error: error);
      } else if (error.error is SocketException) {
        log('xXx xc ${error.error}');
        return BarcodeResponse.makeError(
            error: error,
            errorMsg: prefs.appLanguage == 'en'
                ? 'No Internet Connection'
                : 'لا يوجد إتصال بالشبكة');
      } else {
        log('xXx xc ${error.error}');
        String errorDescription = prefs.appLanguage == 'en'
            ? "Unexpected error occurred"
            : 'حدث خظأ غير متوقع';

        return BarcodeResponse.makeError(
            error: error, errorMsg: errorDescription);
      }
    }
  }
}
