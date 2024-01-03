import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class BaseDioApi {
  late final Dio _dio;

  BaseDioApi(this._dio);

  /// 헤더 세팅
  void setHeader(
      {required String baseUrl, required Map<String, dynamic> header}) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status! < 500;
      },
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 10),
      headers: header,
    );
  }

  Future<Response> dioPost(String url, {required FormData formdata}) async {
    try {
      Response response = await _dio.post(
        url,
        data: formdata,
      );
      return response;
    } on DioException catch (e) {
      //실패시 Exception
      throw {
        "method": "POST",
        "statusCode": e.response?.statusCode,
        "message": e.response?.data["message"] ?? "",
        "url": url,
        "error": e.error,
      };
    }
  }
}
