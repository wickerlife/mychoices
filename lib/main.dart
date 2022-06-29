import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maichoices/app/core/values/colors.dart';
import 'package:maichoices/app/data/services/storage/service.dart';

import 'package:maichoices/app/modules/timeline/binding.dart';
import 'package:maichoices/app/modules/timeline/view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        // On Android S+ devices, use the provided dynamic color scheme.
        // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
        lightColorScheme = lightDynamic.harmonized();
        // (Optional) Customize the scheme as desired. For example, one might
        // want to use a brand color to override the dynamic [ColorScheme.secondary].
        lightColorScheme = lightColorScheme.copyWith(primary: LightColors.yellow);

        // Repeat for the dark color scheme.
        darkColorScheme = darkDynamic.harmonized();
        darkColorScheme = darkColorScheme.copyWith(primary: LightColors.yellow);
      } else {
        // Otherwise, use fallback schemes.
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: LightColors.yellow,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: LightColors.yellow,
          brightness: Brightness.dark,
        );
      }
      return GetMaterialApp(
        title: 'MaiChoices',
        home: const TimelinePage(),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        initialBinding: TimelineBinding(),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
