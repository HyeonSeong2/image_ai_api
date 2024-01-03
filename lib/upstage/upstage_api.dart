import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:open_ai_api/upstage/base_dio_api.dart';

import '../model.dart';

class UpstageAPI extends BaseDioApi {
  UpstageAPI(super.dio);

  Future<UpstageModel> post(String url, {required String fileName}) async {
    FormData formData =
        FormData.fromMap({'image': await MultipartFile.fromFile(fileName)});
    Response response = await dioPost(url, formdata: formData);
    var responseString = response.toString(); // 왜 data만 String이 되었지?
    var decodedData = jsonDecode(responseString);
    UpstageModel upstageModel = UpstageModel.fromJson(decodedData);
    return upstageModel;
  }
}
