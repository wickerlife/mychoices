import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/add_choice/binding.dart';
import 'package:maichoices/app/modules/add_choice/view.dart';
import 'package:maichoices/app/modules/choice/controller.dart';
import 'package:maichoices/app/widgets/cappbar.dart';
import 'package:maichoices/app/widgets/cbutton.dart';
import 'package:maichoices/app/widgets/tag_item.dart';

class ChoiceView extends GetView<ChoiceController> {
  const ChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              CAppBar(
                name: 'My Choice',
                subtitle: 'Your choice details',
                dark: false,
                leadingIcon: Icons.close,
                leadingFunction: () {
                  Get.back();
                },
                trailingIcon: Icons.edit,
                trailingFunction: () async {
                  final choicePackage = await Get.to(
                    () => const AddChoiceView(),
                    binding: AddChoiceBinding(),
                    arguments: {
                      'choice': controller.choice.value.toJson(),
                      'date': controller.choice.value.date.toIso8601String(),
                    },
                  );
                  if (choicePackage != null && choicePackage.success) {
                    controller.editChoice(choicePackage.choice);
                  }
                },
              ),
              SizedBox(
                height: 78.0.hp,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 6.0.wp,
                        top: 3.0.hp,
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            if (controller.choice.value.relevance != RelevanceEnum.none) ...[
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: controller.getRelevanceColor(controller.choice.value.relevance),
                                ),
                              ),
                              SizedBox(
                                width: 3.0.wp,
                              )
                            ],
                            Text(
                              controller.choice.value.title,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 6.0.wp,
                        right: 6.0.wp,
                        top: 3.0.wp,
                      ),
                      child: Container(
                        width: 100.0.wp,
                        decoration: BoxDecoration(
                          color: LightColors.primaryLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            6.0.wp,
                          ),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.choice.value.choice.value,
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 2.0.wp,
                                  ),
                                  child: Text(
                                    '${DateFormat.yMd().format(controller.choice.value.date)}  at  ${formatDate(DateTime(2019, 08, 1, controller.choice.value.date.hour, controller.choice.value.date.minute), [
                                          hh,
                                          ':',
                                          nn,
                                          " ",
                                          am
                                        ]).toString()}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0.sp,
                                      color: LightColors.primaryDark,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 3.0.wp,
                                  ),
                                  child: Text(
                                    controller.choice.value.description ?? '',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Category Section
                    Padding(
                      padding: EdgeInsets.only(
                        top: 6.0.wp,
                        left: 6.0.wp,
                        right: 6.0.wp,
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            Icon(
                              controller.choice.value.category.icon,
                              size: 24,
                            ),
                            SizedBox(
                              width: 6.0.wp,
                            ),
                            Text(
                              controller.choice.value.category.name,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Considered Options
                    Obx(
                      () => Container(
                        child: (controller.choice.value.options != null && controller.choice.value.options!.isNotEmpty)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: 6.0.wp,
                                  left: 6.0.wp,
                                  right: 6.0.wp,
                                ),
                                child: SizedBox(
                                  width: 100.0.wp,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Considered Options',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0.wp,
                                      ),
                                      Container(
                                        width: 100.0.wp,
                                        decoration: BoxDecoration(
                                          color: LightColors.primaryLight,
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: 23.5.hp,
                                          ),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              ...controller.choice.value.options!
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (entry) => OptionItem(
                                                      value: entry.value,
                                                      isLast: (entry.key == controller.choice.value.options!.length - 1),
                                                    ),
                                                  )
                                                  .toList(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),

                    // Tags Section
                    Obx(
                      () => Container(
                        child: (controller.choice.value.tags == null || controller.choice.value.tags!.isEmpty)
                            ? null
                            : Padding(
                                padding: EdgeInsets.only(
                                  top: 6.0.wp,
                                  left: 6.0.wp,
                                  right: 6.0.wp,
                                ),
                                child: SizedBox(
                                  width: 100.0.wp,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tags',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0.wp,
                                      ),
                                      SizedBox(
                                        height: 7.5.wp,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            ...controller.choice.value.tags!
                                                .map(
                                                  (tag) => TagItem(
                                                    name: tag.name,
                                                    backgroundColor: LightColors.primaryLight,
                                                    textColor: LightColors.accentLight,
                                                  ),
                                                )
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 6.0.wp,
                        right: 6.0.wp,
                        bottom: 6.0.wp,
                        top: 6.0.wp,
                      ),
                      child: CButton(
                        enabled: true,
                        dark: true,
                        onTap: () {
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
                                      'GO BACK',
                                      style: TextStyle(
                                        color: LightColors.accentDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back(
                                        closeOverlays: true,
                                      );
                                      controller.deleteChoice();
                                    },
                                    child: const Text(
                                      'DELETE',
                                      style: TextStyle(
                                        color: LightColors.accentDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                                title: const Text(
                                  'Delete Choice?',
                                  style: TextStyle(
                                    color: LightColors.accentDark,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                content: const Text(
                                  'Are you sure you want to delete this choice? This action cannot be undone.',
                                  style: TextStyle(
                                    color: LightColors.accentLight,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        title: 'Delete',
                        darkColor: LightColors.accentDark,
                        shadow: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String value;
  final bool isLast;

  const OptionItem({
    Key? key,
    required this.value,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6.0.wp,
            vertical: 4.0.wp,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 12.0.sp,
            ),
          ),
        ),
        if (!isLast)
          Container(
            width: 100.0.wp,
            height: 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: LightColors.primaryDark,
            ),
          ),
      ],
    );
  }
}
