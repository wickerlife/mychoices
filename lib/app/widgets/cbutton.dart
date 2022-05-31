import 'package:flutter/material.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';

class CButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback onTap;
  final String? fontFamily;
  final IconData? leadingIcon;
  final bool? dark;
  final double? width;
  final double? height;
  final Color? darkColor;
  final bool? shadow;

  const CButton({
    Key? key,
    required this.title,
    required this.enabled,
    required this.onTap,
    this.fontFamily,
    this.leadingIcon,
    this.dark,
    this.width,
    this.height,
    this.darkColor,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: (enabled && (dark != true || shadow == true))
            ? [
                BoxShadow(
                  color: (dark == true) ? LightColors.accentLight : LightColors.primaryDark,
                  offset: const Offset(2.0, 2.0),
                  blurRadius: 8,
                )
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: width ?? 41.5.wp,
          height: height ?? 16.3.wp,
          decoration: BoxDecoration(
            color: (enabled && dark != true) ? LightColors.primary : darkColor ?? LightColors.accentLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            splashFactory: enabled ? null : NoSplash.splashFactory,
            canRequestFocus: enabled,
            onTap: enabled ? onTap : null,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null)
                    Icon(
                      leadingIcon,
                      size: 14,
                      color: (enabled && dark != true) ? LightColors.accentLight : LightColors.primary,
                    ),
                  if (leadingIcon != null)
                    SizedBox(
                      width: 2.0.wp,
                    ),
                  Text(
                    title,
                    style: TextStyle(
                      color: (enabled && dark != true) ? LightColors.accentLight : LightColors.primary,
                      fontFamily: fontFamily ?? 'Raleway',
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
