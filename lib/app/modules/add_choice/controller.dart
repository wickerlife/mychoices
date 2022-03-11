import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:mychoices/app/data/models/choice.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';

class AddChoiceController extends GetxController {
  ChoiceRepository choiceRepository;
  TagRepository tagRepository;
  AddChoiceController({
    required this.choiceRepository,
    required this.tagRepository,
  });

  // Name & Category
  final newChoiceFormKey = GlobalKey<FormState>();
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
  final selectedRelevance = relevanceEnum.none.obs;

  // Description
  final descriptionController = TextEditingController();

  // Made / To Make Decision Switch

  // Choice Made Input

  // Add other options toggle

  // Other/Possible Options

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tags.assignAll(tagRepository.readTags());
    tempTags.assignAll(tagRepository.readTags());
    ever(tags, (_) => tagRepository.writeTags(tags));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    tagsInput.dispose();
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

  Color getRelevanceColor(relevanceEnum relevance) {
    Color color;
    if (relevance == relevanceEnum.high) {
      color = LightColors.red;
    } else if (relevance == relevanceEnum.medium) {
      color = LightColors.yellow;
    } else {
      color = LightColors.blue;
    }

    if (selectedRelevance.value == relevance) {
      return color;
    }
    return color.withOpacity(0.4);
  }

  void clearRelevance() {
    selectedRelevance.value = relevanceEnum.none;
  }
}
