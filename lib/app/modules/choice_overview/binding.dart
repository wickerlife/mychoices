import 'package:get/get.dart';
import 'package:maichoices/app/data/provider/choice/provider.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/modules/choice_overview/controller.dart';

class ChoiceOverviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChoiceOverviewController(
        choiceRepository: ChoiceRepository(
          choiceProvider: ChoiceProvider(),
        ),
      ),
    );
  }
}
