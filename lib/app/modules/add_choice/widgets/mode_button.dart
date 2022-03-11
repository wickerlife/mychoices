import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';

class ModeButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const ModeButton({
    Key? key,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: (selected)
            ? [
                const BoxShadow(
                  color: LightColors.primaryDark,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 8,
                )
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: 41.5.wp,
          height: 16.3.wp,
          decoration: BoxDecoration(
            color: (selected) ? LightColors.primary : LightColors.accentLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: onTap,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: selected ? LightColors.accentLight : LightColors.primary,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
