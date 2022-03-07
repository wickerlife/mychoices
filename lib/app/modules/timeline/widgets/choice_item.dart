import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/modules/timeline/controller.dart';
import 'package:mychoices/app/modules/timeline/widgets/tag_item.dart';

class ChoiceItem extends StatelessWidget {
  final controller = Get.find<TimelineController>();
  final int index;

  ChoiceItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.0.wp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            controller.getFormattedChoiceTime(index),
            style: TextStyle(
              color: LightColors.primaryDark,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12.0.sp,
            ),
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
                      onTap: () {},
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
                                      'Date',
                                      style: TextStyle(
                                        color: LightColors.primary,
                                        fontFamily: 'Raleway',
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (controller.isRandomChoice(index))
                                      SizedBox(
                                        width: 2.4.wp,
                                      ),
                                    if (controller.isRandomChoice(index))
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
                                          .getChoiceTags(index)
                                          .sublist(0, 2)
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
                                controller.getChoiceCategoryIcon(index),
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
                    color: controller.getChoiceRelevanceColor(index),
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
