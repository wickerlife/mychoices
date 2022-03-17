import 'package:get/get.dart';
import 'package:mychoices/app/data/provider/choice/provider.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';
import 'package:mychoices/app/modules/choice_overview/controller.dart';

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
