import 'package:flutter/material.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/modules/choice/binding.dart';
import 'package:maichoices/app/modules/choice/view.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';
import 'package:maichoices/app/widgets/tag_item.dart';

class ChoiceItem extends StatelessWidget {
  final controller = Get.find<TimelineController>();
  final Choice choice;

  ChoiceItem({
    Key? key,
    required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.0.hp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.getFormattedChoiceTime(choice),
            style: TextStyle(
              color: LightColors.primaryDark,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12.0.sp,
            ),
          ),
          SizedBox(
            width: 8.2.wp,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2, 2),
                  blurRadius: 8,
                  color: LightColors.accentDark.withOpacity(0.4),
                ),
              ],
            ),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    width: 67.4.wp,
                    height: 25.4.wp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: LightColors.accentDark,
                    ),
                    child: InkWell(
                      splashColor: LightColors.accentLight,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      onTap: () {
                        Get.to(() => const ChoiceView(), binding: ChoiceBinding(), arguments: {
                          'choice': choice.toJson(),
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.0.wp,
                          vertical: 4.0.wp,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      choice.title,
                                      style: TextStyle(
                                        color: LightColors.primary,
                                        fontFamily: 'Raleway',
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (choice.random)
                                      SizedBox(
                                        width: 2.4.wp,
                                      ),
                                    if (choice.random)
                                      const Icon(
                                        Icons.auto_awesome,
                                        color: LightColors.primary,
                                        size: 16,
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.0.wp),
                                  child: Row(
                                    children: [
                                      ...controller
                                          .getChoiceTags(choice)
                                          .sublist(0, (controller.getChoiceTags(choice).length > 2) ? 2 : controller.getChoiceTags(choice).length)
                                          .map<Widget>(
                                            (tag) => TagItem(
                                              name: tag.name,
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 6.0.wp),
                              child: Icon(
                                choice.category.icon,
                                color: LightColors.primary,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 25.4.wp,
                  width: 3.5.wp,
                  decoration: BoxDecoration(
                    color: controller.getChoiceRelevanceColor(choice),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
