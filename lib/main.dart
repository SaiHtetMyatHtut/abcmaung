import 'package:abc_maung/lang/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abc_maung/view/routes.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:get_storage/get_storage.dart';
void main() async {
  await GetStorage.init();
  Get.put(Controller());
  final _local = Get.put(LocalizationService());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: routes,
    theme: ThemeData(primaryColor: Colors.white),
    locale: _local.locale,
    fallbackLocale: LocalizationService.fallbackLocale,
    translations: LocalizationService(),
  ));
}