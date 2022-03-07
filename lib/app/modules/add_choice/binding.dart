import 'package:get/get.dart';
import 'package:mychoices/app/data/provider/choice/provider.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';
import 'package:mychoices/app/modules/add_choice/controller.dart';

class AddChoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddChoiceController(
        choiceRepository: ChoiceRepository(
          choiceProvider: ChoiceProvider(),
        ),
      ),
    );
  }
}
