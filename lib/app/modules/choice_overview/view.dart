import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/choice_overview/controller.dart';
import 'package:maichoices/app/modules/timeline/view.dart';
import 'package:maichoices/app/widgets/cappbar.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/widgets/cbutton.dart';

class ChoiceOverviewView extends GetView<ChoiceOverviewController> {
  const ChoiceOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              CAppBar(
                name: 'New Choice',
                subtitle: 'Picking an option for you!',
                dark: false,
                leadingIcon: Icons.arrow_back,
                leadingFunction: () {
                  Get.back(result: ChoicePackage(success: false));
                },
                trailingFunction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: LightColors.primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'KEEP EDITING',
                              style: TextStyle(
                                color: Color.fromARGB(255, 138, 134, 134),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back(closeOverlays: true, result: ChoicePackage(success: false));
                            },
                            child: const Text(
                              'CONTINUE',
                              style: TextStyle(
                                color: LightColors.accentDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        title: const Text(
                          'Discard Choice?',
                          style: TextStyle(
                            color: LightColors.accentDark,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: const Text(
                          'Are you sure you want to discard this choice? Your changes will not be saved and cannot be recovered.',
                          style: TextStyle(
                            color: LightColors.accentLight,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      );
                    },
                  );
                },
                trailingIcon: Icons.close,
              ),
              SizedBox(
                height: 4.0.hp,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 6.0.wp,
                  right: 6.0.wp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        controller.chosen.value ? 'Chosen option:' : 'Options to choose from:',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 3.0.wp,
                  left: 6.0.wp,
                  right: 6.0.wp,
                ),
                child: Container(
                  width: 100.0.wp,
                  decoration: BoxDecoration(
                    color: LightColors.primaryLight,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.loose(
                      Size(
                        100.0.wp,
                        65.0.hp,
                      ),
                    ),
                    child: Obx(
                      () => ListView(
                        shrinkWrap: true,
                        children: (controller.chosen.value)
                            ? [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.0.wp,
                                    vertical: 4.0.wp,
                                  ),
                                  child: Text(
                                    controller.chosenOption.value,
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                ),
                              ]
                            : [
                                ...controller.choice.value.options!
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.0.wp,
                                              vertical: 4.0.wp,
                                            ),
                                            child: Text(
                                              entry.value,
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 12.0.sp,
                                              ),
                                            ),
                                          ),
                                          if (entry.key != controller.choice.value.options!.length - 1)
                                            Container(
                                              width: 100.0.wp,
                                              height: 0.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                color: LightColors.primaryDark,
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0.wp,
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                          top: controller.chosen.value ? 2.0.hp : 0.0,
                        ),
                        child: controller.chosen.value
                            ? TextButton(
                                onPressed: () {
                                  controller.choseRandomly();
                                },
                                child: Text(
                                  'Choose Again',
                                  style: TextStyle(
                                    color: LightColors.accentDark,
                                    fontFamily: 'Raleway',
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.0.hp,
                      ),
                      child: Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                            bottom: 6.0.wp,
                          ),
                          child: CButton(
                            enabled: true,
                            title: controller.chosen.value ? 'Save' : 'Choose',
                            onTap: () {
                              controller.chosen.value ? controller.saveOption() : controller.choseRandomly();
                            },
                            dark: true,
                            darkColor: LightColors.accentDark,
                            shadow: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
