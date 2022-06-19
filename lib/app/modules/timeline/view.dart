import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/modules/timeline/controller.dart';
import 'package:maichoices/app/modules/timeline/widgets/add_fab.dart';
import 'package:maichoices/app/modules/timeline/widgets/timeline_item.dart';
import 'package:maichoices/app/modules/timeline/widgets/timeline_page_item.dart';
import 'package:maichoices/app/widgets/cappbar.dart';
import 'package:get/get.dart';

class TimelinePage extends GetView<TimelineController> {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: LightColors.primary,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Obx(
                () => CAppBar(
                  name: 'Hello, David',
                  subtitle: '${controller.allChoices.where((choice) => choice.compareDate(controller.getSelectedDay())).length} Choices on this day',
                  // trailingImage: 'assets/images/profile.jpg',
                  imageFunction: () {},
                  trailingIcon: Icons.today,
                  trailingFunction: () {
                    controller.showToday();
                  },
                  dark: false,
                ),
              ),
              // Timeline
              Padding(
                padding: EdgeInsets.only(top: 2.0.wp),
                child: SizedBox(
                  height: 26.0.wp,
                  width: Get.width,
                  child: Obx(
                    () => ListView.builder(
                      addAutomaticKeepAlives: false,
                      physics: const ClampingScrollPhysics(),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      controller: controller.timelineScrollController,
                      itemBuilder: (BuildContext context, int index) {
                        if ((index > controller.totalDays.length - 1)) {
                          return Container();
                        }
                        return TimelineItem(index: index);
                      },
                      itemCount: controller.totalDays.length + 1,
                    ),
                  ),
                ),
              ),

              // Choices PageView
              Expanded(
                child: PageView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  controller: controller.pageViewController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (index) {
                    if (!controller.isPageViewScrolling.value) controller.showDay(index, fromTimeline: true);
                  },
                  itemBuilder: ((context, index) {
                    if ((index > controller.totalDays.length - 1)) {
                      return Container();
                    }
                    return TimelinePageItem(index: index);
                  }),
                  itemCount: controller.totalDays.length,
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 2.9.wp, bottom: 6.0.wp),
        child: AddChoiceActionButton(),
      ),
    );
  }
}
