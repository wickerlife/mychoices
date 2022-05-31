import 'package:flutter/material.dart';
import 'package:maichoices/app/core/utils/extensions.dart';
import 'package:maichoices/app/core/values/colors.dart';

class CAppBar extends StatelessWidget {
  final IconData? leadingIcon;
  final VoidCallback? leadingFunction;
  final IconData? trailingIcon;
  final VoidCallback? trailingFunction;
  final String? trailingImage;
  final VoidCallback? imageFunction;
  final String name;
  final String subtitle;
  final bool dark;

  CAppBar({
    Key? key,
    required this.name,
    required this.subtitle,
    this.leadingIcon,
    this.leadingFunction,
    this.trailingIcon,
    this.trailingFunction,
    this.trailingImage,
    this.imageFunction,
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
                IconButton(
                  icon: Icon(
                    leadingIcon,
                    size: 24,
                    color: dark ? LightColors.primary : LightColors.accentDark,
                  ),
                  onPressed: leadingFunction,
                ),
              if (leadingIcon != null)
                SizedBox(
                  width: 6.0.wp,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 22.0.sp,
                        fontWeight: FontWeight.bold,
                        color: dark ? LightColors.primary : LightColors.accentDark,
                        fontFamily: 'Raleway'),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w600,
                        color: dark ? LightColors.primaryLight : LightColors.primaryDark,
                        fontFamily: 'Raleway'),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (trailingIcon != null)
                IconButton(
                  icon: Icon(
                    trailingIcon,
                    size: 24,
                    color: dark ? LightColors.primary : LightColors.accentDark,
                  ),
                  onPressed: trailingFunction,
                ),
              if (trailingIcon != null && trailingImage != null)
                SizedBox(
                  width: 6.0.wp,
                ),
              if (trailingImage != null)
                GestureDetector(
                  onTap: imageFunction,
                  child: Container(
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
                ),
            ],
          ),
        ],
      ),
    );
  }
}
