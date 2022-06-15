import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/models/choice.dart';
import 'package:maichoices/app/data/services/storage/repository.dart';
import 'package:maichoices/app/modules/choice_overview/binding.dart';
import 'package:maichoices/app/modules/choice_overview/view.dart';

class AddChoiceController extends GetxController {
  ChoiceRepository choiceRepository;
  TagRepository tagRepository;
  AddChoiceController({
    required this.choiceRepository,
    required this.tagRepository,
  });

  final editing = false.obs;
  final didEdit = false.obs;
  final initialDate = DateTime.parse(Get.arguments['date']);
  // Save Button
  final saveButton = false.obs;

  // Name & Category

  final TextEditingController nameController = TextEditingController();
  // Category Popup
  final chosenCategory = categoriesMap.values.toList()[0].obs;
  // Tags Popup
  final TextEditingController tagsInput = TextEditingController();
  final tags = <Tag>[].obs;
  final selectedTags = <Tag>[].obs;
  // Temp
  final tagInputValue = ''.obs;
  final tempTags = <Tag>[].obs;
  final tempSelectedTags = <Tag>[].obs;
  final queryTags = <Tag>[].obs;
  final showAddTagBtn = false.obs;
  final savedSelection = false.obs;

  // Relevance
  final selectedRelevance = RelevanceEnum.none.obs;

  // Description
  final descriptionController = TextEditingController();

  // Made / To Make Decision Switch
  final choseMode = false.obs;
  final isRandom = false.obs;

  // Choice Made Input
  final decisionController = TextEditingController();

  // Date picker for made choice
  final selectedDate = DateTime.now().obs;
  final dateController = DateFormat.yMd().format(DateTime.now()).obs;
  final selectedTime = TimeOfDay.fromDateTime(DateTime.now()).obs;
  final timeController = formatDate(DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute), [hh, ':', nn, " ", am]).toString().obs;

  // Add other options toggle
  final addConsideredChoices = false.obs;

  // Other/Possible Options
  final optionsControllers = <TextEditingController>[].obs;
  final optionsControllerFocus = <FocusNode>[];

  @override
  void onInit() {
    super.onInit();
    tags.assignAll(tagRepository.readTags());
    tempTags.assignAll(tagRepository.readTags());
    ever(tags, (_) => tagRepository.writeTags(tags));
    // Set Iniital Date
    selectedDate.value = initialDate;
    dateController.value = dateFormat(selectedDate.value);
    // Keyboard Listener

    // Detect Incoming Arguments
    if (Get.arguments['choice'] != null) {
      final choice = Choice.fromJson(Get.arguments['choice']);
      choseMode.value = true;
      editing.value = true;
      saveButton.value = true;
      nameController.text = choice.title;
      selectedRelevance.value = choice.relevance;
      descriptionController.text = choice.description ?? '';
      isRandom.value = choice.random;
      if (choice.tags != null) {
        selectedTags.assignAll(List<Tag>.from(choice.tags!));
      }

      selectedDate.value = choice.date;
      dateController.value = dateFormat(selectedDate.value);
      selectedTime.value = TimeOfDay(
        hour: choice.date.hour,
        minute: choice.date.minute,
      );
      timeController.value = formatDate(DateTime(2019, 08, 1, selectedTime.value.hour, selectedTime.value.minute), [hh, ':', nn, " ", am]).toString();

      if (choice.options != null) {
        final options = choice.options;
        options!.remove(choice.choice.value);

        addConsideredChoices.value = true;
        optionsControllers.assignAll(
          options
              .map(
                (e) => TextEditingController.fromValue(TextEditingValue(text: e)),
              )
              .toList(),
        );

        optionsControllerFocus.assignAll(
          options
              .map(
                (_) => FocusNode(),
              )
              .toList(),
        );
      }
      decisionController.text = choice.choice.value;
      decisionController.addListener(
        () {
          didEdit.value = false;
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    tagsInput.dispose();
    descriptionController.dispose();
    decisionController.dispose();
    for (var controller in optionsControllers) {
      controller.dispose();
    }
  }

  bool isChosenCategory(Category category) {
    return chosenCategory.value.name == category.name;
  }

  bool isCheckedTag(Tag tag) {
    if (tempSelectedTags.contains(tag)) {
      return true;
    }
    return false;
  }

  void toggleCheckedTag(Tag tag) {
    if (tempSelectedTags.contains(tag)) {
      tempSelectedTags.remove(tag);
    } else {
      tempSelectedTags.add(tag);
    }
  }

  void onTagInputChange(String value) {
    tagInputValue.value = value.toLowerCase();
    var show = true;
    for (Tag tag in tempTags) {
      if (tagInputValue.value == tag.name) {
        show = false;
      }
    }
    if (tagInputValue.value != '' && show) {
      showAddTagBtn.value = true;
      queryTags.clear();
      for (var tag in tempTags) {
        if (tag.name.contains(tagInputValue.value)) {
          queryTags.add(tag);
        }
      }
    } else {
      showAddTagBtn.value = false;
    }
  }

  void createTag() {
    tempTags.insert(0, Tag(name: tagInputValue.value));
    tempSelectedTags.add(Tag(name: tagInputValue.value));
    tagsInput.clear();
    onTagInputChange('');
  }

  void saveTagSelection() {
    selectedTags.clear();
    for (var tag in tempSelectedTags) {
      selectedTags.add(tag);
      if (!tags.contains(tag)) {
        tags.add(tag);
      }
    }
  }

  void cancelTagSelection() {
    tempSelectedTags.clear();
    for (var tag in selectedTags) {
      tempSelectedTags.add(tag);
    }
    tempTags.clear();
    for (var tag in tags) {
      tempTags.add(tag);
    }
  }

  Color getRelevanceColor(RelevanceEnum relevance) {
    Color color;
    if (relevance == RelevanceEnum.high) {
      color = LightColors.red;
    } else if (relevance == RelevanceEnum.medium) {
      color = LightColors.yellow;
    } else {
      color = LightColors.blue;
    }

    if (selectedRelevance.value == relevance) {
      return color;
    }
    return color.withOpacity(0.4);
  }

  void saveBtnEnabled() {
    bool emptyOptions() {
      var filled = 0;
      for (var controller in optionsControllers) {
        if (controller.value.text != '') {
          filled += 1;
        }
      }
      if (isRandom.value && !editing.value) {
        return filled < 2;
      }
      return filled < 1;
    }

    var enabled = true;
    if (nameController.value.text == '' || !choseMode.value) {
      enabled = false;
    }

    if (!isRandom.value) {
      if (decisionController.value.text == '') enabled = false;
      if (addConsideredChoices.value && emptyOptions()) enabled = false;
    }

    if (emptyOptions() && isRandom.value) {
      enabled = false;
    }
    saveButton.value = enabled;
  }

  void save() async {
    final options = optionsControllers.where((element) => element.value.text != '').map((e) => e.value.text).toList();
    if (!isRandom.value || editing.value) {
      options.insert(0, decisionController.text);
    }

    var choice = Choice(
      title: nameController.value.text,
      category: chosenCategory.value,
      choice: ChoiceValue(
        value: (!isRandom.value || editing.value) ? decisionController.value.text : '',
        toInitialize: (isRandom.value && !editing.value),
        changed: false,
      ),
      relevance: selectedRelevance.value,
      tags: selectedTags.toList(),
      random: isRandom.value,
      date: isRandom.value
          ? DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day, selectedTime.value.hour, selectedTime.value.minute)
          : DateTime(
              selectedDate.value.year,
              selectedDate.value.month,
              selectedDate.value.day,
              selectedTime.value.hour,
              selectedTime.value.minute,
            ),
      description: (descriptionController.value.text == '') ? null : descriptionController.value.text,
      options: options,
    );

    if (isRandom.value && !editing.value) {
      var choicePackage = await Get.to(
        () => const ChoiceOverviewView(),
        binding: ChoiceOverviewBinding(),
        arguments: {
          'choice': choice.toJson(),
        },
      );
      if (choicePackage is ChoicePackage && choicePackage.success) {
        Get.back(result: choicePackage);
      }
    } else {
      Get.back(result: ChoicePackage(success: true, choice: choice));
    }
  }

  String dateFormat(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  bool compareDate(DateTime first, DateTime second) {
    if (first.year == second.year && first.month == second.month && first.day == second.day) {
      return true;
    }
    return false;
  }
}
