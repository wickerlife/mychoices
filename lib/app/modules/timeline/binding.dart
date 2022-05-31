import 'package:get/get.dart';
import 'package:maichoices/app/data/provider/choice/provider.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import '../timeline/controller.dart';

class TimelineBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TimelineController(
        choiceRepository: ChoiceRepository(
          choiceProvider: ChoiceProvider(),
        ),
      ),
    );
  }
}
