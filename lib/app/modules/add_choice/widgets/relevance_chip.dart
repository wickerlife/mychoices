import 'package:flutter/material.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/add_choice/controller.dart';

class RelevanceChip extends StatelessWidget {
  final AddChoiceController controller;
  final relevanceEnum relevance;
  const RelevanceChip({
    Key? key,
    required this.controller,
    required this.relevance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: 24.0.wp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: controller.getRelevanceColor(relevance),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          onTap: () {
            controller.selectedRelevance.value = relevance;
          },
          child: Padding(
            padding: EdgeInsets.all(2.0.wp),
            child: Center(
              child: Text(
                relevance.name.capitalizeInitial,
                style: TextStyle(
                  color: (relevance == controller.selectedRelevance.value) ? LightColors.primary : LightColors.primaryDark,
                  fontFamily: 'Raleway',
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
