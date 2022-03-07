import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:mychoices/app/modules/timeline/controller.dart';
import 'package:mychoices/app/modules/timeline/widgets/choice_item.dart';
import 'package:mychoices/app/modules/timeline/widgets/timeline_item.dart';
import 'package:mychoices/app/widgets/cappbar.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/widgets/cnavbar.dart';

class TimelinePage extends GetView<TimelineController> {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              CAppBar(
                title: 'Hello, David',
                subtitle: '${controller.choices.length} Choices on this day',
                trailingImage: 'assets/images/profile.jpg',
                imageFunction: () {},
                trailingIcon: Icons.today,
                trailingFunction: () {
                  controller.showToday();
                },
                dark: false,
              ),

              // Timeline
              Padding(
                padding: EdgeInsets.only(top: 2.0.wp),
                child: SizedBox(
                  height: 26.0.wp,
                  width: Get.width,
                  child: Obx(
                    () => ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      controller: controller.timelineScrollController,
                      itemBuilder: (BuildContext context, int index) {
                        if (index > controller.totalDays.length - 1) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: LightColors.primaryLight,
                            ),
                          );
                        }
                        return TimelineItem(index: index);
                      },
                      itemCount: controller.totalDays.length + 1,
                    ),
                  ),
                ),
              ),

              // Choices ListView
              Padding(
                padding: EdgeInsets.only(
                  top: 4.0.hp,
                  left: 6.0.wp,
                  right: 6.0.wp,
                ),
                child: Obx(
                  () => ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ChoiceItem(index: index);
                    },
                    itemCount: controller.choices.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CNavBar(),
    );
  }
}
