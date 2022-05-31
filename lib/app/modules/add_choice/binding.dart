import 'package:get/get.dart';
import 'package:maichoices/app/data/provider/choice/provider.dart';
import 'package:maichoices/app/data/provider/tag/provider.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/modules/add_choice/controller.dart';

class AddChoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddChoiceController(
        choiceRepository: ChoiceRepository(
          choiceProvider: ChoiceProvider(),
        ),
        tagRepository: TagRepository(
          tagProvider: TagProvider(),
        ),
      ),
    );
  }
}
