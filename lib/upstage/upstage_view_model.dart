import 'package:flutter/cupertino.dart';
import 'package:open_ai_api/model.dart';
import 'package:open_ai_api/upstage/upstage_controller.dart';

class UpstageViewModel extends ChangeNotifier {
  UpstageModel? upstageModel;

  Future<void> imageInfo({required String fileName}) async {
    upstageModel = await UpstageController().upstagePost(fileName: fileName);
    notifyListeners();
  }
}
