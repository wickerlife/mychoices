import 'package:get/get.dart';
import 'package:mychoices/app/data/provider/choice/provider.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';
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
