import 'package:flutter/material.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';

class TimelineItem extends StatelessWidget {
  final controller = Get.find<TimelineController>();
  final int index;

  TimelineItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(right: 6.0.wp),
        child: Material(
          color: Colors.transparent,
          child: Ink(
            width: 18.0.wp,
            decoration: BoxDecoration(
              color: controller.isCurrentDay(index)
                  ? controller.isSelected(index)
                      ? LightColors.accentDark
                      : LightColors.accentLight
                  : controller.isSelected(index)
                      ? LightColors.primaryLight
                      : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: InkWell(
              splashFactory: controller.totalDays[index].isBefore(controller.firstDay) ? NoSplash.splashFactory : null,
              splashColor: controller.isCurrentDay(index) ? LightColors.accentLight : LightColors.primaryLight,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onTap: () {
                controller.showDay(index, fromTimeline: true);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.8.wp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.getWeekDay(index),
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp,
                        color: LightColors.primaryDark,
                      ),
                    ),
                    Text(
                      controller.totalDays[index].day.toString(),
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.sp,
                          color: (controller.isValidDate(index))
                              ? controller.isCurrentDay(index)
                                  ? LightColors.primary
                                  : LightColors.accentDark
                              : LightColors.primaryDark),
                    ),
                    Text(
                      controller.getMonth(index),
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp,
                        color: LightColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
