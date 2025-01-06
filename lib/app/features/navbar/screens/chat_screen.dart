import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/navbar/widgets/chat_item_widget.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:enjaz_app/core/widgets/app_search_text_filed.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.chatScreenText),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.allMembersRoute);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FadeInLeft(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppPaddingWidget(child: AppSearchTextFiled()),
            ),
            SliverList.builder(
                itemBuilder: (context,index)=>ChatItemWidget(),
              itemCount: 5,
            )
          ],
        ),
      ),
    );
  }
}
