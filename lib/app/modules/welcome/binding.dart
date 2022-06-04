import 'package:get/get.dart';
import 'package:maichoices/app/data/provider/settings/provider.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/modules/welcome/controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WelcomeController(
        settingRepository: SettingRepository(
          settingProvider: SettingProvider(),
        ),
      ),
    );
  }
}
