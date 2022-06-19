import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/mock_data.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:date_utils/date_utils.dart' as date_util;
import 'package:intl/intl.dart';

class TimelineController extends GetxController {
  ChoiceRepository choiceRepository;
  TimelineController({required this.choiceRepository});
  final allChoices = <Choice>[].obs;

  // Day Timeline Controller
  final firstLoadComplete = false.obs;
  final firstDay = modelUser.firstDay;
  final today = DateTime.now().obs;
  late ScrollController timelineScrollController = ScrollController();
  late PageController pageViewController = PageController();
  final totalDays = <DateTime>[].obs;
  final selectedIndex = 0.obs;

  // Choice List Controller
  @override
  void onInit() {
    super.onInit();
    // Load Repository
    allChoices.assignAll(choiceRepository.readChoices());
    ever(allChoices, (_) => choiceRepository.writeChoices(allChoices));
    // Timeline Setup
    setTimeline(today.value);
    firstLoadComplete.value = true;
    timelineScrollController.addListener(() {
      if (timelineScrollController.position.pixels == timelineScrollController.position.maxScrollExtent) {
        fetchDates();
      }
    });
    var current = today.value;
    Stream timer = Stream.periodic(const Duration(seconds: 1), (i) {
      current = current.add(const Duration(seconds: 1));
      return current;
    });
    timer.listen((current) => setTimeline(current));
  }

  @override
  void onClose() {
    timelineScrollController.dispose();
    pageViewController.dispose();
    super.onClose();
  }

  DateTime getSelectedDay() {
    return totalDays[selectedIndex.value];
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
    totalDays.add(totalDays[totalDays.length - 1].subtract(const Duration(days: 1)));
  }

  bool isCurrentDay(int index) {
    DateTime select = totalDays[index];
    if (today.value.year == select.year && today.value.month == select.month && today.value.day == select.day) {
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
    timelineScrollController.animateTo(0.0, duration: const Duration(milliseconds: 1000), curve: Curves.ease);
  }

  bool isRandomChoice(int index) {
    final choice = allChoices[index];
    return choice.random;
  }

  String getFormattedChoiceTime(Choice choice) {
    return DateFormat('Hm').format(choice.date);
  }

  Color getChoiceRelevanceColor(Choice choice) {
    if (choice.relevance == RelevanceEnum.high) {
      return LightColors.red;
    } else if (choice.relevance == RelevanceEnum.medium) {
      return LightColors.yellow;
    } else if (choice.relevance == RelevanceEnum.low) {
      return LightColors.blue;
    }
    return Colors.transparent;
  }

  List<dynamic> getChoiceTags(Choice choice) {
    if (choice.tags == null) {
      return [];
    }
    List<Tag> tags = choice.tags!.map((tag) => Tag(name: tag.name)).toList();
    return tags;
  }

  void addChoice(Choice choice) {
    allChoices.add(choice);
    allChoices.sort((a, b) => b.date.compareTo(a.date));
  }

  void setTimeline(DateTime current) {
    if (!firstLoadComplete.value || current.day != today.value.day) {
      date_util.DateUtils.daysInRange(
        modelUser.firstDay,
        DateTime.now().add(
          const Duration(hours: 12),
        ),
      ).toSet().toList().forEach(
        (element) {
          if (element.month == DateTime.now().month) {
            if (element.day <= DateTime.now().day) totalDays.add(element);
          } else {
            totalDays.add(element);
          }
        },
      );
      if (totalDays.isEmpty) {
        totalDays.add(DateTime.now());
      }
      // Reverse List
      for (var i = 0; i < totalDays.length / 2; i++) {
        var temp = totalDays[i];
        totalDays[i] = totalDays[totalDays.length - 1 - i];
        totalDays[totalDays.length - 1 - i] = temp;
      }
      today.value = DateTime.now();
    }
  }

  void navigateToDay(int index, {bool pageView = false}) {
    if (totalDays[index].isBefore(firstDay)) {
      return;
    } else {
      selectedIndex.value = index;
    }

    if (pageView == false) {
      pageViewController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
}
