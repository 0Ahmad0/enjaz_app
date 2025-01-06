import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/assets_manager.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllMembersScreen extends StatelessWidget {
  const AllMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.allMembersText),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.messagesRoute);
                },
                trailing: SvgPicture.asset(
                  AssetsManager.chatIcon,
                ),
                leading: CircleAvatar(),
                title: Text(
                  'Name ${++index}',
                  style: StyleManager.font14Regular(),
                ),
              ),
          separatorBuilder: (_, __) => Divider(
                height: 0,
              ),
          itemCount: 20),
    );
  }
}
