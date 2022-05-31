import 'package:flutter/material.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';

class TagItem extends StatelessWidget {
  final String name;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  const TagItem({
    Key? key,
    required this.name,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 1.2.wp,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? LightColors.accentLight,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.4.wp),
          child: Text(
            "#$name",
            style: TextStyle(
              color: textColor ?? LightColors.primaryLight,
              fontFamily: 'Raleway',
              fontSize: fontSize ?? 11.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
