import 'package:get/get.dart';
import 'package:maichoices/app/data/provider/choice/provider.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/modules/choice/controller.dart';

class ChoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChoiceController(
        choiceRepository: ChoiceRepository(
          choiceProvider: ChoiceProvider(),
        ),
      ),
    );
  }
}
