import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';
import 'package:maichoices/app/modules/timeline/widgets/choice_item.dart';

class TimelinePageItem extends StatelessWidget {
  final int index;
  final TimelineController controller = Get.find<TimelineController>();

  TimelinePageItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: (controller.allChoices.where((choice) => choice.compareDate(controller.totalDays[index])).toList().isEmpty)
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: 8.0.hp,
                ),
                child: const Center(
                  child: Text(
                    'No choices recorded on this day',
                    style: TextStyle(
                      color: LightColors.primaryDark,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              )
            : ListView(
                children: [
                  ...controller.allChoices
                      .where((choice) => choice.compareDate(controller.totalDays[index]))
                      .toList()
                      .map((choice) => ChoiceItem(
                            choice: choice,
                          ))
                      .toList(),
                  SizedBox(
                    height: 3.0.hp,
                  )
                ],
              ),
      ),
    );
  }
}
