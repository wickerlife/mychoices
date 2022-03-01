import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/data/mock_data.dart';
import 'package:mychoices/app/data/models/choice.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';
import 'package:date_utils/date_utils.dart' as date_util;
import 'package:intl/intl.dart';

class TimelineController extends GetxController {
  ChoiceRepository choiceRepository;
  TimelineController({required this.choiceRepository});
  final choices = <Choice>[].obs;

  // Day Timeline Controller
  final firstDay = modelUser.firstDay;
  final today = DateTime.now();
  late ScrollController timelineScrollController;
  final totalDays = <DateTime>[].obs;
  final selectedIndex = 0.obs;

  // Choice List Controller
  @override
  void onInit() {
    super.onInit();
    // Load Repository
    choices.assignAll(choiceRepository.readChoices());
    ever(choices, (_) => choiceRepository.writeChoices(choices));
    // Timeline Setup
    date_util.DateUtils.daysInRange(
      modelUser.firstDay,
      DateTime.now(),
    ).toSet().toList().forEach((element) {
      totalDays.add(element);
    });
    if (totalDays.isEmpty) {
      totalDays.add(DateTime.now());
    }
    // Reverse List
    for (var i = 0; i < totalDays.length / 2; i++) {
      var temp = totalDays[i];
      totalDays[i] = totalDays[totalDays.length - 1 - i];
      totalDays[totalDays.length - 1 - i] = temp;
    }
    timelineScrollController = ScrollController();
    timelineScrollController.addListener(() {
      if (timelineScrollController.position.pixels ==
          timelineScrollController.position.maxScrollExtent) {
        fetchDates();
      }
    });
  }

  @override
  void onClose() {
    timelineScrollController.dispose();
    super.onClose();
  }

  String getWeekDay(int index) {
    String weekDay = DateFormat('E').format(totalDays[index]);
    return weekDay;
  }

  String getMonth(int index) {
    String month = DateFormat('MMM').format(totalDays[index]);
    return month;
  }

  void fetchDates() {
    totalDays
        .add(totalDays[totalDays.length - 1].subtract(const Duration(days: 1)));
  }

  bool isCurrentDay(int index) {
    DateTime select = totalDays[index];
    if (today.year == select.year &&
        today.month == select.month &&
        today.day == select.day) {
      return true;
    }
    return false;
  }

  bool isValidDate(int index) {
    if (totalDays[index].isAfter(firstDay.subtract(
          const Duration(days: 1),
        )) &&
        totalDays[index].isBefore(
          DateTime.now().add(
            const Duration(days: 1),
          ),
        )) {
      return true;
    }
    return false;
  }

  bool isSelected(int index) {
    if (selectedIndex.value == index) {
      return true;
    }
    return false;
  }
}
