import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:open_ai_api/upstage/upstage_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  String? fileName;

  final UpstageViewModel vm = UpstageViewModel();

  Function()? listener;
  @override
  void initState() {
    listener = () {
      if (mounted) {
        setState(() {
          Logger().d("setState호출");
        });
      }
    };
    vm.addListener(listener!);
    super.initState();
  }

  @override
  void dispose() {
    vm.removeListener(listener!);
    listener = null;
    super.dispose();
  }

  Future<void> onePick() async {
    // 이미지 1개 불러오기
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      fileName = image!.path;
    });
  }

  Future<void> capturePhoto() async {
    // 카메라 촬영으로 불러오기
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      fileName = photo!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                await onePick();
                Logger().d("이미지 불러오기 실행 fileName : $fileName");
              },
              child: const Text("Gallery Photo"),
            ),
            TextButton(
              onPressed: () async {
                await capturePhoto();
                Logger().d("캡처 성공 fileName : $fileName");
              },
              child: const Text("Capture Photo"),
            ),
            fileName == ""
                ? const SizedBox()
                : SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(
                      File(fileName!),
                      fit: BoxFit.cover,
                    ),
                  ),
            TextButton(
              onPressed: () {
                vm.imageInfo(fileName: fileName!);
              },
              child: Text("ImageInfo 요청 : ${vm.upstageModel?.pages[0].text}"),
            ),
          ],
        ),
      ),
    );
  }
}
