import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/core/values/colors.dart';
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
    choices.assignAll(choiceRepository.readTodaysChoices());
    choices.add(modelChoice);
    ever(choices, (_) => choiceRepository.writeChoices(choices));
    // Timeline Setup
    date_util.DateUtils.daysInRange(
      modelUser.firstDay,
      DateTime.now().add(
        const Duration(hours: 12),
      ),
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

  void showToday() {
    selectedIndex.value = 0;
    // Scroll to selected value
    timelineScrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 1000), curve: Curves.ease);
  }

  bool isRandomChoice(int index) {
    final choice = choices[index];
    return choice.random;
  }

  String getFormattedChoiceTime(int index) {
    final choice = choices[index];
    return DateFormat('Hm').format(choice.date);
  }

  IconData getChoiceCategoryIcon(int index) {
    final Choice choice = choices[index];
    return choice.category.icon;
  }

  Color getChoiceRelevanceColor(int index) {
    final choice = choices[index];
    if (choice.relevance == relevanceEnum.high) {
      return LightColors.red;
    } else if (choice.relevance == relevanceEnum.medium) {
      return LightColors.yellow;
    }
    return LightColors.blue;
  }

  List<dynamic> getChoiceTags(int index) {
    final choice = choices[index];
    if (choice.tags == null) {
      return [];
    }
    List<Tag> tags = choice.tags!.map((tag) => Tag(name: tag.name)).toList();
    return tags;
  }
}
