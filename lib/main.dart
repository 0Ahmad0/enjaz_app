import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import '/enjaz_app.dart';
import '/core/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'app/features/core/controllers/connection_time.dart';
import 'firebase_options.dart';
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

  /// for show last connection
  ConnectionTime.instance.connectTime();


  await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true
  );

  await requestAllPermissions();

  /// To Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// To Fix Bug In Text Showing In Release Mode
  await ScreenUtil.ensureScreenSize();

  await GetStorage.init();
  runApp(
    EnjazApp(
      appRouter: AppRouter(),
    ),
  );
}
