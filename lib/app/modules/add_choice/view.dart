import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/utils/keys.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:mychoices/app/data/models/choice.dart';
import 'package:mychoices/app/modules/add_choice/controller.dart';
import 'package:mychoices/app/modules/add_choice/widgets/card.dart';
import 'package:mychoices/app/modules/add_choice/widgets/choose_category_alert.dart';
import 'package:mychoices/app/modules/add_choice/widgets/choose_tags_alert.dart';
import 'package:mychoices/app/modules/add_choice/widgets/input_field.dart';
import 'package:mychoices/app/modules/add_choice/widgets/mode_button.dart';
import 'package:mychoices/app/modules/add_choice/widgets/relevance_chip.dart';
import 'package:mychoices/app/widgets/cappbar.dart';
import 'package:mychoices/app/widgets/cbutton.dart';
import 'package:mychoices/app/widgets/tag_item.dart';

class AddChoiceView extends GetView<AddChoiceController> {
  const AddChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate.value,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: LightColors.accentDark, // header background color
                onPrimary: LightColors.primary, // header text color
                onSurface: LightColors.primaryLight, // body text color
              ),
              dialogBackgroundColor: LightColors.accentLight,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: LightColors.primary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        controller.selectedDate.value = picked;
        controller.dateController.value = DateFormat.yMd().format(controller.selectedDate.value);
      }
    }

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: controller.selectedTime.value,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: LightColors.primary, // header background color
                onPrimary: LightColors.accentDark, // header text color
                onSurface: LightColors.primaryLight,
                onBackground: LightColors.primary,
              ),
              dialogBackgroundColor: LightColors.primary,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: LightColors.primary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        controller.selectedTime.value = picked;
        String hour = controller.selectedTime.value.hour.toString();
        String minute = controller.selectedTime.value.minute.toString();
        String time = hour + ' : ' + minute;
        controller.timeController.value = time;
        controller.timeController.value = formatDate(
          DateTime(
            2022,
            11,
            08,
            controller.selectedTime.value.hour,
            controller.selectedTime.value.minute,
          ),
          [hh, ':', nn, " ", am],
        ).toString();
      }
    }

    return Scaffold(
      backgroundColor: LightColors.accentDark,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              CAppBar(
                name: !controller.editing.value ? 'New Choice' : 'Editing Choice',
                subtitle: !controller.editing.value ? 'Make or register a choice' : "Edit this choice's info",
                imageFunction: () {},
                trailingIcon: Icons.close,
                trailingFunction: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: LightColors.accentLight,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'KEEP EDITING',
                              style: TextStyle(
                                color: LightColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back(
                                closeOverlays: true,
                              );
                              Get.back(
                                result: ChoicePackage(success: false),
                              );
                            },
                            child: const Text(
                              'CONTINUE',
                              style: TextStyle(
                                color: LightColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        title: Text(
                          (controller.editing.value) ? 'Cancel Edits?' : 'Discard Choice?',
                          style: const TextStyle(
                            color: LightColors.primary,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: Text(
                          (controller.editing.value)
                              ? 'Are you sure you want to discard the edits you made? Your changes will be lost.'
                              : 'Are you sure you want to discard this choice? Your changes will not be saved and cannot be recovered.',
                          style: const TextStyle(
                            color: LightColors.primaryLight,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      );
                    },
                  );
                },
                dark: true,
              ),
              Expanded(
                child: ListView(
                  children: [
                    // TODO CARDS
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                      child: Form(
                        key: newChoiceFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CCard(
                              title: 'Name & Category',
                              trailingAction: TextButton.icon(
                                icon: const Icon(
                                  Icons.label_outline,
                                  color: LightColors.primary,
                                  size: 16,
                                ),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
                                  padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => ChooseTagsAlert(
                                      controller: controller,
                                    ),
                                  ).then(
                                    (value) {
                                      if (controller.savedSelection.value == true) {
                                        controller.saveTagSelection();
                                      } else {
                                        controller.cancelTagSelection();
                                      }
                                      controller.savedSelection.value = false;
                                      controller.tagsInput.clear();
                                      controller.tagInputValue.value = '';
                                    },
                                  );
                                },
                                label: const Text(
                                  'Add Tags',
                                  style: TextStyle(
                                    color: LightColors.primary,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // CHOOSE CATEGORY
                                      Material(
                                        color: Colors.transparent,
                                        child: Ink(
                                          width: 14.0.wp,
                                          height: 14.0.wp,
                                          decoration: BoxDecoration(
                                            color: LightColors.accentDark,
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(context: context, builder: (_) => ChooseCatgoryAlert(controller: controller));
                                            },
                                            splashColor: LightColors.accentLight,
                                            customBorder: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Obx(
                                                () => Icon(
                                                  controller.chosenCategory.value.icon,
                                                  color: LightColors.primary,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // TEXT FIELD
                                      InputField(
                                        controller: controller.nameController,
                                        width: 59.0.wp,
                                        height: 14.0.wp,
                                        fillColor: LightColors.accentDark,
                                        hintColor: LightColors.primaryDark,
                                        textColor: LightColors.primary,
                                        hintText: 'Choice #5',
                                        showCancelBtn: false,
                                        maxLength: 16,
                                        onChange: (value) {
                                          controller.saveBtnEnabled();
                                        },
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.0.wp,
                                    ),
                                    child: Obx(
                                      () => Align(
                                        alignment: Alignment.topLeft,
                                        child: Wrap(
                                          spacing: 1.5.wp,
                                          alignment: WrapAlignment.start,
                                          children: [
                                            ...controller.selectedTags.map(
                                              (tag) => TagItem(
                                                name: tag.name,
                                                backgroundColor: LightColors.accentDark,
                                                textColor: LightColors.primaryDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 6.0.wp,
                            ),
                            Obx(
                              () => CCard(
                                title: 'Relevance',
                                trailingAction: (controller.selectedRelevance.value != relevanceEnum.none)
                                    ? TextButton.icon(
                                        onPressed: () {
                                          controller.selectedRelevance.value = relevanceEnum.none;
                                        },
                                        style: ButtonStyle(
                                          minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
                                          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        icon: const Icon(
                                          Icons.cancel,
                                          size: 14,
                                          color: LightColors.primary,
                                        ),
                                        label: const Text(
                                          'Clear',
                                          style: TextStyle(
                                            color: LightColors.primary,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RelevanceChip(
                                      controller: controller,
                                      relevance: relevanceEnum.high,
                                    ),
                                    RelevanceChip(
                                      controller: controller,
                                      relevance: relevanceEnum.medium,
                                    ),
                                    RelevanceChip(
                                      controller: controller,
                                      relevance: relevanceEnum.low,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.0.wp,
                            ),
                            CCard(
                              title: 'Description',
                              child: InputField(
                                controller: controller.descriptionController,
                                width: 78.5.wp,
                                height: 14.0.wp,
                                fillColor: LightColors.accentDark,
                                hintColor: LightColors.primaryDark,
                                textColor: LightColors.primary,
                                hintText: 'Describe your dilemma',
                                showCancelBtn: true,
                                maxLength: 300,
                                maxLines: 5,
                              ),
                            ),

                            Obx(
                              () => Column(
                                children: (controller.editing.value)
                                    ? []
                                    : [
                                        SizedBox(
                                          height: 6.0.wp,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ModeButton(
                                                title: 'Made Choice',
                                                selected: (!controller.isRandom.value && controller.choseMode.value),
                                                onTap: () {
                                                  controller.isRandom.value = false;
                                                  controller.choseMode.value = true;
                                                  controller.optionsControllers.clear();
                                                  controller.optionsControllerFocus.clear();
                                                  controller.saveBtnEnabled();
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.0.wp,
                                            ),
                                            Expanded(
                                              child: ModeButton(
                                                title: 'Help me decide',
                                                selected: (controller.isRandom.value && controller.choseMode.value),
                                                onTap: () {
                                                  controller.isRandom.value = true;
                                                  controller.choseMode.value = true;
                                                  controller.decisionController.clear();
                                                  controller.addConsideredChoices.value = false;
                                                  controller.optionsControllers.clear();
                                                  controller.optionsControllerFocus.clear();
                                                  controller.optionsControllers.addAll([TextEditingController(), TextEditingController()]);
                                                  controller.optionsControllerFocus.addAll([FocusNode(), FocusNode()]);
                                                  controller.saveBtnEnabled();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                              ),
                            ),

                            // MADE CHOICE CARDS
                            // Decision
                            Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: (!controller.choseMode.value)
                                    ? []
                                    : (!controller.isRandom.value || controller.editing.value)
                                        ? [
                                            SizedBox(
                                              height: 6.0.wp,
                                            ),
                                            CCard(
                                              title: 'Decision',
                                              child: InputField(
                                                controller: controller.decisionController,
                                                width: 78.5.wp,
                                                height: 14.0.wp,
                                                fillColor: LightColors.accentDark,
                                                hintColor: LightColors.primaryDark,
                                                textColor: LightColors.primary,
                                                hintText: 'What decision did you take?',
                                                showCancelBtn: false,
                                                maxLength: 20,
                                                onChange: (value) {
                                                  controller.saveBtnEnabled();
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6.0.wp,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CButton(
                                                    title: controller.compareDate(controller.selectedDate.value, DateTime.now())
                                                        ? 'Today'
                                                        : controller.dateController.value,
                                                    onTap: () {
                                                      selectDate(context);
                                                    },
                                                    enabled: true,
                                                    dark: true,
                                                    fontFamily: 'Montserrat',
                                                    leadingIcon: Icons.date_range,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 6.0.wp,
                                                ),
                                                Expanded(
                                                  child: CButton(
                                                    enabled: true,
                                                    title: controller.timeController.value,
                                                    onTap: () {
                                                      selectTime(context);
                                                    },
                                                    dark: true,
                                                    fontFamily: 'Montserrat',
                                                    leadingIcon: Icons.watch_later_outlined,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 6.0.wp,
                                            ),
                                            // Add other options toggle
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Add considered choices',
                                                  style: TextStyle(
                                                    color: LightColors.primary,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0.sp,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 3.0.wp,
                                                  ),
                                                  child: SizedBox(
                                                    width: 16,
                                                    height: 16,
                                                    child: Obx(
                                                      () => Checkbox(
                                                        value: controller.addConsideredChoices.value,
                                                        onChanged: (value) {
                                                          controller.addConsideredChoices.value = !controller.addConsideredChoices.value;
                                                          controller.optionsControllers.clear();
                                                          controller.optionsControllerFocus.clear();
                                                          controller.saveBtnEnabled();
                                                        },
                                                        checkColor: LightColors.accentLight,
                                                        activeColor: LightColors.primary,
                                                        fillColor: MaterialStateProperty.resolveWith(
                                                          (_) => LightColors.primary,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // Considered Options
                                            Obx(
                                              () => Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: (controller.addConsideredChoices.value)
                                                    ? [
                                                        SizedBox(
                                                          height: 6.0.wp,
                                                        ),
                                                        CCard(
                                                          title: 'Considered Options',
                                                          trailingAction: TextButton.icon(
                                                            onPressed: () {
                                                              controller.optionsControllerFocus.add(FocusNode());
                                                              controller.optionsControllers.add(TextEditingController());
                                                            },
                                                            style: ButtonStyle(
                                                              minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
                                                              padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                            ),
                                                            icon: const Icon(
                                                              Icons.add,
                                                              size: 14,
                                                              color: LightColors.primary,
                                                            ),
                                                            label: const Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                color: LightColors.primary,
                                                                fontFamily: 'Raleway',
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Obx(
                                                            () => Column(
                                                              children: [
                                                                InputField(
                                                                  controller: controller.decisionController,
                                                                  width: 78.5.wp,
                                                                  height: 14.0.wp,
                                                                  fillColor: LightColors.accentDark,
                                                                  hintColor: LightColors.primaryDark,
                                                                  textColor: LightColors.primary,
                                                                  hintText: 'Option #1 (taken decision)',
                                                                  showCancelBtn: false,
                                                                  maxLength: 26,
                                                                  readOnly: true,
                                                                ),

                                                                // User managed considered options
                                                                ...controller.optionsControllers.map(
                                                                  (optionController) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.only(
                                                                        top: 2.0.wp,
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: InputField(
                                                                              controller: optionController,
                                                                              width: 78.5.wp,
                                                                              height: 14.0.wp,
                                                                              fillColor: LightColors.accentDark,
                                                                              hintColor: LightColors.primaryDark,
                                                                              textColor: LightColors.primary,
                                                                              hintText:
                                                                                  'Option #${controller.optionsControllers.indexOf(optionController) + 2}',
                                                                              showCancelBtn: false,
                                                                              maxLength: 26,
                                                                              focusNode: controller.optionsControllerFocus[
                                                                                  controller.optionsControllers.indexOf(optionController)],
                                                                              onChange: (_) {
                                                                                controller.saveBtnEnabled();
                                                                              },
                                                                              inputAction: (value) {
                                                                                controller.optionsControllerFocus[
                                                                                        controller.optionsControllers.indexOf(optionController)]
                                                                                    .unfocus();

                                                                                final focus = FocusNode();
                                                                                Timer(const Duration(milliseconds: 1), () {
                                                                                  controller.optionsControllerFocus.add(focus);
                                                                                  controller.optionsControllers.add(TextEditingController());
                                                                                  FocusScope.of(context).requestFocus(focus);
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed: () {
                                                                              controller.optionsControllerFocus
                                                                                  .removeAt(controller.optionsControllers.indexOf(optionController));
                                                                              controller.optionsControllers.remove(optionController);
                                                                              controller.saveBtnEnabled();
                                                                            },
                                                                            icon: const Icon(
                                                                              Icons.cancel,
                                                                              color: LightColors.primary,
                                                                              size: 16,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                    : [],
                                              ),
                                            ),
                                          ]
                                        : [
                                            SizedBox(
                                              height: 6.0.wp,
                                            ),
                                            // Help me Decide Widgets
                                            CCard(
                                              title: 'Possible Options',
                                              trailingAction: TextButton.icon(
                                                onPressed: () {
                                                  controller.optionsControllerFocus.add(FocusNode());
                                                  controller.optionsControllers.add(TextEditingController());
                                                },
                                                style: ButtonStyle(
                                                  minimumSize: MaterialStateProperty.resolveWith((states) => Size.zero),
                                                  padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 14,
                                                  color: LightColors.primary,
                                                ),
                                                label: const Text(
                                                  'Add',
                                                  style: TextStyle(
                                                    color: LightColors.primary,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              child: Obx(
                                                () => Column(
                                                  children: [
                                                    InputField(
                                                      controller: controller.optionsControllers[0],
                                                      focusNode: controller.optionsControllerFocus[0],
                                                      width: 78.5.wp,
                                                      height: 14.0.wp,
                                                      fillColor: LightColors.accentDark,
                                                      hintColor: LightColors.primaryDark,
                                                      textColor: LightColors.primary,
                                                      hintText: 'Option #1',
                                                      showCancelBtn: false,
                                                      maxLength: 26,
                                                      onChange: (_) {
                                                        controller.saveBtnEnabled();
                                                      },
                                                      inputAction: (value) {
                                                        controller.optionsControllerFocus[0].unfocus();

                                                        final focus = FocusNode();
                                                        Timer(const Duration(milliseconds: 1), () {
                                                          controller.optionsControllerFocus.add(focus);
                                                          controller.optionsControllers.add(TextEditingController());
                                                          FocusScope.of(context).requestFocus(focus);
                                                        });
                                                      },
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 2.0.wp,
                                                      ),
                                                      child: InputField(
                                                        controller: controller.optionsControllers[1],
                                                        focusNode: controller.optionsControllerFocus[1],
                                                        width: 78.5.wp,
                                                        height: 14.0.wp,
                                                        fillColor: LightColors.accentDark,
                                                        hintColor: LightColors.primaryDark,
                                                        textColor: LightColors.primary,
                                                        hintText: 'Option #2',
                                                        showCancelBtn: false,
                                                        maxLength: 26,
                                                        onChange: (_) {
                                                          controller.saveBtnEnabled();
                                                        },
                                                        inputAction: (value) {
                                                          controller.optionsControllerFocus[1].unfocus();

                                                          final focus = FocusNode();
                                                          Timer(const Duration(milliseconds: 1), () {
                                                            controller.optionsControllerFocus.add(focus);
                                                            controller.optionsControllers.add(TextEditingController());
                                                            FocusScope.of(context).requestFocus(focus);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    // User managed considered options
                                                    if (controller.optionsControllers.length > 2)
                                                      ...controller.optionsControllers.sublist(2).map(
                                                        (optionController) {
                                                          return Padding(
                                                            padding: EdgeInsets.only(
                                                              top: 2.0.wp,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: InputField(
                                                                    controller: optionController,
                                                                    width: 78.5.wp,
                                                                    height: 14.0.wp,
                                                                    fillColor: LightColors.accentDark,
                                                                    hintColor: LightColors.primaryDark,
                                                                    textColor: LightColors.primary,
                                                                    hintText:
                                                                        'Option #${controller.optionsControllers.indexOf(optionController) + 1}',
                                                                    focusNode: controller.optionsControllerFocus[
                                                                        controller.optionsControllers.indexOf(optionController)],
                                                                    showCancelBtn: false,
                                                                    maxLength: 26,
                                                                    onChange: (_) {
                                                                      controller.saveBtnEnabled();
                                                                    },
                                                                    inputAction: (value) {
                                                                      controller.optionsControllerFocus[
                                                                              controller.optionsControllers.indexOf(optionController)]
                                                                          .unfocus();

                                                                      final focus = FocusNode();
                                                                      Timer(const Duration(milliseconds: 1), () {
                                                                        controller.optionsControllerFocus.add(focus);
                                                                        controller.optionsControllers.add(TextEditingController());
                                                                        FocusScope.of(context).requestFocus(focus);
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  onPressed: () {
                                                                    controller.optionsControllerFocus
                                                                        .removeAt(controller.optionsControllers.indexOf(optionController));
                                                                    controller.optionsControllers.remove(optionController);
                                                                    controller.saveBtnEnabled();
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.cancel,
                                                                    color: LightColors.primary,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                              ),
                            ),
                            SizedBox(
                              height: 6.0.wp,
                            ),

                            // SAVE BUTTON
                            Obx(
                              () => CButton(
                                title: (controller.isRandom.value && !controller.editing.value) ? 'Next' : 'Save',
                                enabled: controller.saveButton.value,
                                onTap: () {
                                  controller.save();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8.0.wp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
