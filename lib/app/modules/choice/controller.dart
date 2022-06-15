import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';

class ChoiceController extends GetxController {
  TimelineController controller = Get.find<TimelineController>();
  final ChoiceRepository choiceRepository;
  ChoiceController({
    required this.choiceRepository,
  });

  final choice = Choice.fromJson(Get.arguments['choice']).obs;
  final edited = false.obs;



  Color getRelevanceColor(relevanceEnum relevance) {
    Color color;
    if (relevance == relevanceEnum.high) {
      color = LightColors.red;
    } else if (relevance == relevanceEnum.medium) {
      color = LightColors.yellow;
    } else {
      color = LightColors.blue;
    }

    return color;
  }

  void editChoice(Choice updated) {
    edited.value = true;
    controller.allChoices.remove(choice.value);
    //choice.value.update(updated);
    choice.value = updated;
    controller.allChoices.add(updated);
  }

  void deleteChoice() {
    controller.allChoices.remove(choice.value);
    Get.back();
  }
}
