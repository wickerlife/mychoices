import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/data/services/storage/repository.dart';

class AddChoiceController extends GetxController {
  ChoiceRepository choiceRepository;
  AddChoiceController({required this.choiceRepository});
  // Name & Category
  late TextEditingController nameController;

  // Relevance

  // Description

  // Made / To Make Decision Switch

  // Choice Made Input

  // Add other options toggle

  // Other/Possible Options

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    nameController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void close() {}
}
