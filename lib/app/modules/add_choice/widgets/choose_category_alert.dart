import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/add_choice/controller.dart';

class ChooseCatgoryAlert extends StatelessWidget {
  final AddChoiceController controller;
  const ChooseCatgoryAlert({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(
              color: LightColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      title: Text(
        'Choose Category',
        style: TextStyle(
          color: LightColors.primary,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          fontSize: 14.0.sp,
        ),
      ),
      backgroundColor: LightColors.accentLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      content: SizedBox(
        width: 85.0.wp,
        height: 45.0.hp,
        child: Center(
          child: ListView(
            children: [
              ...categoriesMap.values
                  .map(
                    (Category category) => Padding(
                      padding: EdgeInsets.only(bottom: 2.5.wp),
                      child: GestureDetector(
                        onTap: () {
                          controller.chosenCategory.value = category;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Icon
                              Obx(
                                () => Container(
                                  width: 11.3.wp,
                                  height: 11.3.wp,
                                  child: Icon(
                                    category.icon,
                                    color: controller.isChosenCategory(category) ? LightColors.accentDark : LightColors.primary,
                                    size: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    color: controller.isChosenCategory(category) ? LightColors.primary : LightColors.accentDark,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 4.0.wp,
                              ),

                              // Text
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  color: LightColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
