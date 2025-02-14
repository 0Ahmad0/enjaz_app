import 'package:enjaz_app/app/features/auth/screens/login_screen.dart';
import 'package:enjaz_app/app/features/auth/screens/sign_up_screen.dart';
import 'package:enjaz_app/app/features/navbar/screens/navbar_screen.dart';
import 'package:enjaz_app/app/features/profile/controller/profile_controller.dart';
import 'package:enjaz_app/app/features/splash/splash_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/features/messages/screens/messages_screen.dart';
import 'app/features/project_details/screens/project_details_screen.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/utils/color_manager.dart';
import 'core/utils/const_value_manager.dart';
import 'core/utils/string_manager.dart';
import 'core/utils/style_manager.dart';

class EnjazApp extends StatelessWidget {
  const EnjazApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(
          ConstValueManager.widthSize,
          ConstValueManager.heightSize,
        ),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringManager.appName,
            theme: ThemeData(
              dividerColor: ColorManager.hintTextColor,
              primaryColor: ColorManager.primaryColor,
              primarySwatch: ColorManager.primaryColor.toMaterialColor(),
              colorScheme: ColorScheme.fromSeed(
                seedColor: ColorManager.primaryColor,
              ),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                titleTextStyle: StyleManager.font18Medium(),
                backgroundColor: ColorManager.whiteColor,
                shadowColor: ColorManager.whiteColor,
                surfaceTintColor: ColorManager.whiteColor,
                elevation: 1.0,
              ),
              tabBarTheme: TabBarTheme(
                labelColor: ColorManager.whiteColor,
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: MaterialStateProperty.all(
                    ColorManager.primaryColor.withOpacity(.1)),
                unselectedLabelColor: ColorManager.primaryColor,
                indicator: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              inputDecorationTheme: InputDecorationTheme(

                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                suffixIconColor: ColorManager.primaryColor,
              ),
              scaffoldBackgroundColor: ColorManager.whiteColor,
              fontFamily: GoogleFonts.poppins().fontFamily,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    double.maxFinite,
                    ConstValueManager.heightButtonSize,
                  ),
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: ColorManager.grayColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  )),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)
                  ),
                  minimumSize: Size(
                    double.maxFinite,
                    ConstValueManager.heightButtonSize,
                  ),
                ),
              ),
            ),
            // home: NavbarScreen(),
            initialRoute: Routes.initialRoute,
            onGenerateRoute: appRouter.generateRoute,
            routes: {
              Routes.projectDetailsRoute: (_) => ProjectDetailsScreen(),
              Routes.messagesRoute: (_) => MessagesScreen(),
            },
          );
        });
  }
}
