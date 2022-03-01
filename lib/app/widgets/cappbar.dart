import 'package:flutter/material.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/values/colors.dart';

class CAppBar extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? trailingImage;
  final String title;
  final String subtitle;
  final bool dark;

  const CAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
    this.trailingImage,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0.wp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (leadingIcon != null)
                Icon(
                  leadingIcon,
                  size: 24,
                  color: dark ? LightColors.primary : LightColors.accentDark,
                ),
              if (leadingIcon != null)
                SizedBox(
                  width: 6.0.wp,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 22.0.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            dark ? LightColors.primary : LightColors.accentDark,
                        fontFamily: 'Raleway'),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                        color: dark
                            ? LightColors.primaryLight
                            : LightColors.primaryDark,
                        fontFamily: 'Raleway'),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  size: 24,
                  color: dark ? LightColors.primary : LightColors.accentDark,
                ),
              if (trailingIcon != null && trailingImage != null)
                SizedBox(
                  width: 6.0.wp,
                ),
              if (trailingImage != null)
                Container(
                  decoration: const BoxDecoration(color: LightColors.primary),
                  height: 11.5.wp,
                  width: 11.5.wp,
                  child: ClipRRect(
                    child: Image.asset(
                      trailingImage!,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
