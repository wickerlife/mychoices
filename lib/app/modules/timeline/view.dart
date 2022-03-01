import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:mychoices/app/data/mock_data.dart';
import 'package:mychoices/app/modules/timeline/controller.dart';
import 'package:mychoices/app/modules/timeline/widgets/timeline_item.dart';
import 'package:mychoices/app/widgets/cappbar.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/widgets/cnavbar.dart';

class TimelinePage extends GetView<TimelineController> {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            const CAppBar(
              title: 'Hello, David',
              subtitle: '2Choices made Today',
              trailingImage: 'assets/images/profile.jpg',
              trailingIcon: Icons.today,
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
          ],
        ),
      ),
      bottomNavigationBar: CNavBar(),
    );
  }
}
