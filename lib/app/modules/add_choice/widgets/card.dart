import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';

class CCard extends StatelessWidget {
  final String title;
  final Widget child;
  final TextButton? trailingAction;
  const CCard({
    Key? key,
    required this.title,
    required this.child,
    this.trailingAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColors.accentLight,
        borderRadius: BorderRadius.circular(14),
      ),
      width: 82.0.wp,
      child: Padding(
        padding: EdgeInsets.only(
          left: 6.0.wp,
          right: 6.0.wp,
          top: 5.0.wp,
          bottom: 5.0.wp,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: LightColors.primary,
                    fontSize: 14.0.sp,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailingAction != null) trailingAction!,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 4.0.wp,
              ),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
