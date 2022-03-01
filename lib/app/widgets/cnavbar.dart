import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import '../core/values/colors.dart';

class CNavBar extends StatelessWidget {
  const CNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.8.hp,
      width: Get.width,
      decoration: const BoxDecoration(
        color: LightColors.primaryLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.view_day,
            size: 34,
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 8,
                color: LightColors.accentDark.withOpacity(0.4),
              ),
            ]),
            child: Material(
              color: Colors.transparent,
              child: Ink(
                width: 14.6.wp,
                height: 14.6.wp,
                decoration: BoxDecoration(
                  color: LightColors.accentDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  splashColor: LightColors.accentLight,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 24,
                          color: LightColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.settings,
            size: 34,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
