import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:mychoices/app/data/models/choice.dart';
import 'package:mychoices/app/modules/add_choice/controller.dart';
import 'package:mychoices/app/modules/add_choice/widgets/card.dart';
import 'package:mychoices/app/modules/add_choice/widgets/choose_category_alert.dart';
import 'package:mychoices/app/modules/add_choice/widgets/choose_tags_alert.dart';
import 'package:mychoices/app/modules/add_choice/widgets/input_field.dart';
import 'package:mychoices/app/modules/add_choice/widgets/relevance_chip.dart';
import 'package:mychoices/app/widgets/cappbar.dart';
import 'package:mychoices/app/widgets/tag_item.dart';

class AddChoiceView extends GetView<AddChoiceController> {
  const AddChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColors.accentDark,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: ListView(
            children: [
              CAppBar(
                title: 'New Choice',
                subtitle: 'Make or register a choice',
                imageFunction: () {},
                trailingIcon: Icons.close,
                trailingFunction: () {
                  Get.back();
                },
                dark: true,
              ),
              // TODO CARD ONE
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                child: Form(
                  key: controller.newChoiceFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CCard(
                        title: 'Name & Category',
                        trailingAction: TextButton.icon(
                          icon: const Icon(
                            Icons.label_outline,
                            color: LightColors.primary,
                            size: 16,
                          ),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
                            padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ChooseTagsAlert(
                                controller: controller,
                              ),
                            ).then(
                              (value) {
                                if (controller.savedSelection.value == true) {
                                  controller.saveTagSelection();
                                } else {
                                  controller.cancelTagSelection();
                                }
                                controller.savedSelection.value = false;
                                controller.tagsInput.clear();
                                controller.tagInputValue.value = '';
                              },
                            );
                          },
                          label: const Text(
                            'Add Tags',
                            style: TextStyle(
                              color: LightColors.primary,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CHOOSE CATEGORY
                                Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                    width: 14.0.wp,
                                    height: 14.0.wp,
                                    decoration: BoxDecoration(
                                      color: LightColors.accentDark,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(context: context, builder: (_) => ChooseCatgoryAlert(controller: controller));
                                      },
                                      splashColor: LightColors.accentLight,
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Obx(
                                          () => Icon(
                                            controller.chosenCategory.value.icon,
                                            color: LightColors.primary,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // TEXT FIELD
                                InputField(
                                  controller: controller.nameController,
                                  width: 59.0.wp,
                                  height: 14.0.wp,
                                  fillColor: LightColors.accentDark,
                                  hintColor: LightColors.primaryDark,
                                  textColor: LightColors.primary,
                                  hintText: 'Choice #5',
                                  showCancelBtn: false,
                                  maxLength: 16,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.0.wp,
                              ),
                              child: Obx(
                                () => Align(
                                  alignment: Alignment.topLeft,
                                  child: Wrap(
                                    spacing: 1.5.wp,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      ...controller.selectedTags.map(
                                        (tag) => TagItem(
                                          name: tag.name,
                                          backgroundColor: LightColors.accentDark,
                                          textColor: LightColors.primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.0.wp,
                      ),
                      Obx(
                        () => CCard(
                          title: 'Relevance',
                          trailingAction: (controller.selectedRelevance.value != relevanceEnum.none)
                              ? TextButton.icon(
                                  onPressed: () {
                                    controller.selectedRelevance.value = relevanceEnum.none;
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
                                    padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(
                                    Icons.cancel,
                                    size: 14,
                                    color: LightColors.primary,
                                  ),
                                  label: const Text(
                                    'Clear',
                                    style: TextStyle(
                                      color: LightColors.primary,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RelevanceChip(
                                controller: controller,
                                relevance: relevanceEnum.high,
                              ),
                              RelevanceChip(
                                controller: controller,
                                relevance: relevanceEnum.medium,
                              ),
                              RelevanceChip(
                                controller: controller,
                                relevance: relevanceEnum.low,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.0.wp,
                      ),
                      CCard(
                        title: 'Description',
                        child: InputField(
                          controller: controller.descriptionController,
                          width: 78.5.wp,
                          height: 14.0.wp,
                          fillColor: LightColors.accentDark,
                          hintColor: LightColors.primaryDark,
                          textColor: LightColors.primary,
                          hintText: 'Input a tag',
                          showCancelBtn: true,
                          onChange: controller.onTagInputChange,
                          maxLength: 300,
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(
                        height: 6.0.wp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
