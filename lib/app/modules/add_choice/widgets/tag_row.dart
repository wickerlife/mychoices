import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/add_choice/controller.dart';

class TagRow extends StatelessWidget {
  final AddChoiceController controller;
  final Tag tag;
  const TagRow({
    Key? key,
    required this.controller,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Checkbox(
            value: controller.isCheckedTag(tag),
            onChanged: (value) {
              controller.toggleCheckedTag(tag);
            },
            checkColor: LightColors.accentLight,
            activeColor: LightColors.primary,
            fillColor: MaterialStateProperty.resolveWith(
              (_) => LightColors.primary,
            ),
          ),
        ),
        Text(
          tag.name,
          style: TextStyle(
            color: LightColors.primary,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w500,
            fontSize: 14.0.sp,
          ),
        )
      ],
    );
  }
}
