import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final double height;
  final Color fillColor;
  final Color hintColor;
  final Color textColor;
  final String? hintText;
  final Function(String)? onChange;
  final bool showCancelBtn;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? inputAction;
  const InputField({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
    required this.fillColor,
    required this.hintColor,
    required this.textColor,
    required this.showCancelBtn,
    this.maxLength,
    this.hintText,
    this.onChange,
    this.maxLines,
    this.readOnly,
    this.textInputAction,
    this.focusNode,
    this.inputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onFieldSubmitted: (value) {
          if (inputAction != null) {
            inputAction!(value);
          }
        },
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: textInputAction,
        expands: (maxLength != null) ? false : true,
        maxLength: maxLength,
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        readOnly: readOnly ?? false,
        enabled: (readOnly == true) ? false : true,
        focusNode: focusNode,
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 3.5.wp,
            vertical: 4.5.wp,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: LightColors.accentDark,
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontFamily: 'Montserrat',
          ),
          suffixIcon: showCancelBtn
              ? IconButton(
                  splashRadius: 1.0.wp,
                  icon: const Icon(
                    Icons.cancel,
                    size: 14,
                    color: LightColors.primaryDark,
                  ),
                  onPressed: () {
                    controller.clear();
                    if (onChange != null) onChange!('');
                  },
                )
              : null,
        ),
        style: TextStyle(
          color: textColor,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
