import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maichoices/app/data/services/storage/service.dart';

import 'package:maichoices/app/modules/timeline/binding.dart';
import 'package:maichoices/app/modules/timeline/view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MaiChoices',
      home: const TimelinePage(),
      initialBinding: TimelineBinding(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
