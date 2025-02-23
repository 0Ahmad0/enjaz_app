
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../core/controllers/fab_controller.dart';



class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fabController=Get.put(FabController());
    return FloatingActionButton(
        backgroundColor: ColorManager.primaryColor,
        child: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          showMenu(
            context: context,
            position: const RelativeRect.fromLTRB(100, 600, 100, 100),
            items: [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Login as default user'),
                  // title: const Text('تسجيل الدخول كمستخدم عادي'),
                  onTap: () {
                    Navigator.pop(context);
                    fabController.loginAsUser(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.emoji_people),
                  title: const Text('Login as user 2'),
                  // title: const Text('تسجيل الدخول كمدير'),
                  onTap: () {
                    Navigator.pop(context);
                    fabController.loginAsUser2(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.emoji_people),
                  title: const Text('Login as user 3'),
                  // title: const Text('تسجيل الدخول كمدير'),
                  onTap: () {
                    Navigator.pop(context);
                    fabController.loginAsUser3(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.settings_backup_restore),
                  title: const Text('Restore default data'),
                  // title: const Text('استعادة البيانات الافتراضية'),
                  onTap: () async {
                    Navigator.pop(context);

                    fabController.restoreData(context);
                    // context.pushNamed('/settings');
                  },
                ),
              ),
              // PopupMenuItem(
              //   child: ListTile(
              //     leading: const Icon(Icons.info),
              //     title: const Text('حول التطبيق'),
              //     onTap: () {
              //       Navigator.pop(context);
              //       context.pushNamed('/about');
              //     },
              //   ),
              // ),
            ],
          );});
  }
}
