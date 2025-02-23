
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/seeder.dart';
import '../../../../core/local/storage.dart';
import '../../../../core/utils/app_constant.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screens/widgets/key_code_dialog_widget.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class FabController extends GetxController {
  var formKey = GlobalKey<FormState>();

  static FabController get instance => Get.find();
  final keyController = TextEditingController();
  int currentProgress=0;
  int fullProgress=0;
  bool isFirstLogin=true;
  Map<dynamic,bool> mapIsFirst={};
  init() async {
    formKey = GlobalKey<FormState>();

    keyController.clear();
  }
  bool checkIsFirst(item){

   if(!isFirstLogin)
     return false;
   else
     isFirstLogin=false;
   if(!mapIsFirst.containsKey(item))
    {
      mapIsFirst[item]=false;
      return true;
    }
    return false;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> loginAsUser(BuildContext context) async {
    _login(context, "user@gmail.com", "12345678");
  }
  Future<void> loginAsAdmin(BuildContext context) async {
    _login(context, "admin@gmail.com", "12345678");
  }
  Future<void> loginAsUser3(BuildContext context) async {
    _login(context, "user3@gmail.com", "12345678");
  }
  Future<void> loginAsUser2(BuildContext context) async {
    _login(context, "user2@gmail.com", "12345678");
  }

  Future<void> _login(BuildContext context,String email,String password) async {
      final authController=Get.put(AuthController());
      authController.emailController.text=email;
      authController.passwordController.text=password;
      authController.login(context);
  }



  Future<void> restoreData(BuildContext context) async {

    await showDialog(
      context: context,
      builder: (context) {
        return KeyCodeDialogWidget(
          onKeyCodeValid: () async {

            try {
              // ConstantsWidgets.showLoading();
              _calculateProgress(7+1);
              Get.dialog(
                GetBuilder<FabController>(
                    builder: (FabController controller) =>
                        ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
                ),
                barrierDismissible: false,
              );

              await FirebaseFun.deleteAllData();
              _plusProgress();
             await seederAll();

              ConstantsWidgets.closeDialog();
              ConstantsWidgets.TOAST(null,
                  textToast: StringManager.message_successfully_restore, state: true);
            } on FirebaseAuthException catch (e) {
              String errorMessage = FirebaseFun.findTextToast(e.code);
              ConstantsWidgets.closeDialog();
              ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
            } on Exception catch (e) {
              ConstantsWidgets.closeDialog();
              ConstantsWidgets.TOAST(null,
                  textToast: StringManager.errorTryAgainLater, state: false);
            }
          },
        );
      },
    );

    // Get.snackbar(
    //     AppString.message_failure,
    //    errorMessage,
    //     backgroundColor: ColorManager.errorColor
    // );
  }

  seederAll() async {
    await Seeder.file();
    _plusProgress();
    await Seeder.admin();
    _plusProgress();
    await Seeder.user();
    _plusProgress();
    await Seeder.project();
    _plusProgress();
    await Seeder.imageProject();
    _plusProgress();
    await Seeder.reportProject();
    _plusProgress();
    await Seeder.chat();
    _plusProgress();

  }

  _calculateProgress(int length){
    currentProgress=0;
    fullProgress=1;
    fullProgress+=length;
    update();
  }
  _plusProgress(){
    currentProgress++;
    if(currentProgress>fullProgress)
      currentProgress=fullProgress;
    update();
  }


  @override
  Future<void> onInit() async {

    isFirstLogin=!isFirstLogin?isFirstLogin:!((await AppStorage.storageRead(key: AppConstants.rememberMe) as bool?) ??false);

    super.onInit();
  }

  @override
  void onClose() {
    keyController.dispose();

    super.onClose();
  }
}
showDemoRejectMessage(){
  bool isReject=false;
  if(isReject)
  Get.snackbar(
    StringManager.message_failure,
    "You cannot perform the operation in demo mode.",
    // "لا يمكنك إجراء العملية في الوضع التجريبي.",
    //  backgroundColor: ColorManager.errorColor
  );
  return isReject;
}