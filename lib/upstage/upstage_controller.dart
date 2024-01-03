import 'package:dio/dio.dart';
import 'package:open_ai_api/upstage/upstage_api.dart';

import '../model.dart';

class UpstageController {
  UpstageController._();
  static final UpstageController _instance = UpstageController._();
  factory UpstageController() => _instance;

  static String api_key = '0afxItDC4A4cSxQ3LrqIhD9htVyRTOvr';
  static String url = "https://ap-northeast-2.apistage.ai/v1/document-ai/ocr";
  // 모든 Dio의 요청에 기본적으로 셋팅.
  final UpstageAPI _ihpApi = UpstageAPI(
    Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        sendTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 60),
        // 60 seconds
        receiveTimeout: const Duration(seconds: 60), // 60 seconds
        headers: {"Authorization": "Bearer $api_key"},
      ),
    ),
  );

  Future<UpstageModel> upstagePost({required String fileName}) async {
    return await _ihpApi.post(url, fileName: fileName);
  }
}
