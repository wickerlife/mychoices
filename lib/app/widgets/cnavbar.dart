import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/add_choice/binding.dart';
import 'package:maichoices/app/modules/add_choice/view.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';
import '../core/values/colors.dart';

class CNavBar extends StatelessWidget {
  final controller = Get.find<TimelineController>();
  CNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.8.hp,
      width: Get.width,
      decoration: const BoxDecoration(
        color: LightColors.primaryLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          // const Icon(
          //   Icons.view_day,
          //   size: 24,
          // ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 8,
                color: LightColors.accentDark.withOpacity(0.4),
              ),
            ]),
            child: Material(
              color: Colors.transparent,
              child: Ink(
                width: 14.6.wp,
                height: 14.6.wp,
                decoration: BoxDecoration(
                  color: LightColors.accentDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  splashColor: LightColors.accentLight,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  onTap: () async {
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
                    } else {
                      EasyLoading.showError(
                        'Choice was not recorded',
                        maskType: EasyLoadingMaskType.black,
                        dismissOnTap: true,
                        duration: const Duration(seconds: 1),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 24,
                          color: LightColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const Icon(
          //   Icons.settings,
          //   size: 24,
          // )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
