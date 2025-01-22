import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import '/enjaz_app.dart';
import '/core/helpers/extensions.dart';
import '/core/routing/app_router.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'core/routing/routes.dart';
import 'core/utils/const_value_manager.dart';

Future<void> requestAllPermissions() async {
  await [
    Permission.notification,
    Permission.storage,
  ].request();
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// To Init Firebase
  await Firebase.initializeApp();

  /// To Fix Bug In Text Showing In Release Mode
  await ScreenUtil.ensureScreenSize();


  await GetStorage.init();
  await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true
  );
  await requestAllPermissions();


  /// To Init Firebase
  // await Firebase.initializeApp();

  /// To Fix Bug In Text Showing In Release Mode
  await ScreenUtil.ensureScreenSize();

  await GetStorage.init();
  runApp(
    EnjazApp(
      appRouter: AppRouter(),
    ),
  );
}
