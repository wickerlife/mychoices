import 'package:get/get.dart';
import 'package:mychoices/app/data/provider/choice/provider.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';
import 'package:mychoices/app/modules/choice/controller.dart';

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
