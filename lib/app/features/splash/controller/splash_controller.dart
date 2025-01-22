

import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/local/storage.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_constant.dart';
import '../../auth/controller/auth_controller.dart';
import '../../profile/controller/profile_controller.dart';


class SplashController extends GetxController with GetSingleTickerProviderStateMixin   {
  // static SplashController  get instance => Get.find();
   int delaySplash=1;

  
  @override
  Future<void> onInit() async {
    // await initSplash();
    super.onInit();
  }

  Future<void> _loadSplash(BuildContext context)  async {
    await Future.delayed( Duration(seconds: delaySplash), () {
      // Get.offAll(page);
    });


   if((await AppStorage.storageRead(key: AppConstants.rememberMe) as bool?) ??false){
      // ConstantsWidgets.showLoading(context);

      ProfileController profileController=Get.put(ProfileController());

      await profileController.getUser(context);
      // await ProfileController.instance.getUser();
      if(profileController.currentUser.value?.isAdmin??false);
        // context.pushAndRemoveUntil(Routes.homeAdminRoute, predicate: (Route<dynamic> route) =>false);
      // else  if (profileController.currentUser.value?.isOwner ?? false)
      //   context.pushAndRemoveUntil(Routes.ownerHomeRoute,
      //       predicate: (Route<dynamic> route) => false);
      // Get.offAll(NavbarScreen());
        // Get.offAll(NavBarAdminScreen());
      // else  if (profileController.currentUser.value?.isWorker ?? false)
      //   context.pushAndRemoveUntil(Routes.orderTakerHomeRoute,
      //       predicate: (Route<dynamic> route) => false);
      else
        context.pushAndRemoveUntil(Routes.navbarRoute, predicate: (Route<dynamic> route) =>false);

      // Get.offAll(NavbarScreen());
    }else
     context.pushAndRemoveUntil(Routes.loginRoute, predicate: (Route<dynamic> route) =>false);

    // Get.offAll(LoginScreen());
  }
  Future<void> _initSplash(BuildContext context) async {
    await AppStorage.init();
    // Get.put(ProfileController());
    // Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AuthController());
  }
  Future<void> initSplash(BuildContext context) async {
    await _initSplash(context);
    await _loadSplash(context);
  }

}
