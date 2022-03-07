import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';

class TagItem extends StatelessWidget {
  final String name;
  const TagItem({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 1.2.wp,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: LightColors.accentLight,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.4.wp),
          child: Text(
            "#$name",
            style: TextStyle(
              color: LightColors.primaryLight,
              fontFamily: 'Raleway',
              fontSize: 11.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
