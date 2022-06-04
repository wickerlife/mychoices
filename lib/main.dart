import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maichoices/app/data/provider/settings/provider.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/data/services/storage/service.dart';

import 'package:maichoices/app/modules/timeline/binding.dart';
import 'package:maichoices/app/modules/timeline/view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maichoices/app/modules/welcome/binding.dart';
import 'package:maichoices/app/modules/welcome/view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  bool userRegistered() {
    SettingRepository settingRepository = SettingRepository(
      settingProvider: SettingProvider(),
    );

    if (settingRepository.readSettings().fullName == '') {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MaiChoices',
      home: userRegistered() ? const TimelinePage() : const WelcomePage(),
      initialBinding: userRegistered() ? TimelineBinding() : WelcomeBinding(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
