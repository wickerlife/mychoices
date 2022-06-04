import 'dart:math';
import 'package:get/get.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';

class ChoiceOverviewController extends GetxController {
  ChoiceRepository choiceRepository;

  ChoiceOverviewController({
    required this.choiceRepository,
  });

  final choice = Choice.fromJson(Get.arguments['choice']).obs;
  final chosen = false.obs;
  final chosenOption = ''.obs;

  @override
  void onInit() {
    // Load Repository
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void choseRandomly() {
    final random = Random();
    var i = random.nextInt(choice.value.options!.length);
    chosenOption.value = choice.value.options![i];
    chosen.value = true;
  }

  void saveOption() {
    choice.value.choice.value = chosenOption.value;
    choice.value.choice.toInitialize = false;
    Get.back(result: ChoicePackage(success: true, choice: choice.value));
  }
}
