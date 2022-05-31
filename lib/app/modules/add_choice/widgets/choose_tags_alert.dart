import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/modules/add_choice/controller.dart';
import 'package:maichoices/app/modules/add_choice/widgets/input_field.dart';
import 'package:maichoices/app/modules/add_choice/widgets/tag_row.dart';

class ChooseTagsAlert extends StatelessWidget {
  final AddChoiceController controller;
  const ChooseTagsAlert({
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
            'CANCEL',
            style: TextStyle(
              color: LightColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            controller.savedSelection.value = true;
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
        'Add Tags',
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
          child: Column(
            children: [
              InputField(
                controller: controller.tagsInput,
                width: 72.3.wp,
                height: 14.0.wp,
                fillColor: LightColors.accentDark,
                hintColor: LightColors.primaryDark,
                textColor: LightColors.primary,
                hintText: 'Input a tag',
                showCancelBtn: true,
                onChange: controller.onTagInputChange,
                maxLength: 14,
              ),
              SizedBox(
                height: 1.0.hp,
              ),
              SizedBox(
                height: 35.0.hp,
                child: Obx(
                  () => ListView(
                    children: [
                      SizedBox(
                        height: 4.0.wp,
                      ),
                      if (controller.tagInputValue.value != '')
                        ...controller.queryTags.map(
                          (tag) => TagRow(
                            controller: controller,
                            tag: tag,
                          ),
                        ),
                      if (controller.tagInputValue.value == '')
                        ...controller.tempTags.map(
                          (tag) => TagRow(
                            controller: controller,
                            tag: tag,
                          ),
                        ),
                      if (controller.showAddTagBtn.value)
                        Row(
                          children: [
                            Obx(
                              () => TextButton.icon(
                                icon: Icon(
                                  Icons.create,
                                  color: Theme.of(context).primaryColor,
                                  size: 16,
                                ),
                                label: Text(
                                  'Create "${controller.tagInputValue.value}"',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.0.sp,
                                  ),
                                ),
                                onPressed: () {
                                  controller.createTag();
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
