import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/add_choice/binding.dart';
import 'package:maichoices/app/modules/add_choice/view.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';
import '../../../core/values/colors.dart';
import 'package:get/get.dart';

class AddChoiceActionButton extends StatelessWidget {
  final controller = Get.find<TimelineController>();
  AddChoiceActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      foregroundColor: LightColors.accentDark,
      icon: const Icon(Icons.add),
      onPressed: () async {
        dynamic choicePackage = await Get.to(
          () => const AddChoiceView(),
          binding: AddChoiceBinding(),
          arguments: {
            'date': controller.getSelectedDay().toIso8601String(),
          },
        );
        if (choicePackage is ChoicePackage && choicePackage.success) {
          controller.addChoice(choicePackage.choice!);

          EasyLoading.showSuccess(
            'New Choice Recorded!',
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: true,
            duration: const Duration(seconds: 1),
          );
        }
      },
      label: const Text("Add Choice"),
    );
  }
}
