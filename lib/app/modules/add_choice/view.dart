import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mychoices/app/core/utils/extensions.dart';
import 'package:mychoices/app/core/utils/keys.dart';
import 'package:mychoices/app/core/values/colors.dart';
import 'package:mychoices/app/modules/add_choice/controller.dart';
import 'package:mychoices/app/widgets/cappbar.dart';

class AddChoiceView extends GetView<AddChoiceController> {
  const AddChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColors.accentDark,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: ListView(
            children: [
              CAppBar(
                title: 'New Choice',
                subtitle: 'Make or register a choice',
                imageFunction: () {},
                trailingIcon: Icons.close,
                trailingFunction: () {
                  Get.back();
                },
                dark: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                child: Form(
                  child: Container(
                    decoration: BoxDecoration(
                      color: LightColors.accentLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    width: 82.0.wp,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0.wp,
                        vertical: 5.0.wp,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name & Category',
                                style: TextStyle(
                                  color: LightColors.primary,
                                  fontSize: 14.0.sp,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.label_outline,
                                    color: LightColors.primary,
                                    size: 16,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.0.wp),
                                    child: Text(
                                      'Add Tags',
                                      style: TextStyle(
                                        color: LightColors.primary,
                                        fontSize: 12.0.sp,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3.0.wp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: Ink(
                                  width: 11.3.wp,
                                  height: 11.3.wp,
                                  decoration: BoxDecoration(
                                    color: LightColors.accentDark,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    splashColor: LightColors.accentLight,
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.people_outline,
                                        color: LightColors.primary,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 59.0.wp,
                                child: TextFormField(
                                    key: newChoiceFormKey,
                                    controller: controller.nameController),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
