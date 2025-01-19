import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/navbar/screens/support_screen.dart';
import 'package:enjaz_app/app/features/profile/screens/profile_screen.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.settingText),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: (){
              Get.to(()=>ProfileScreen());
            },
            title: Text(StringManager.profileText),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            onTap: (){
              Get.to(()=>SupportScreen());
            },
            title: Text(StringManager.supportText),
            leading: Icon(Icons.headphones_rounded),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
