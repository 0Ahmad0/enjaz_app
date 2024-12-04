import 'package:enjaz_app/app/features/auth/controller/auth_controller.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/extensions.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/routing/routes.dart';
import 'package:enjaz_app/core/utils/color_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.pushNamed(Routes.messagesRoute);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.iPjtJwLhXF9N9Vd2OzyerwHaHa?rs=1&pid=ImgDetMain'),
              ),
              title: Text(
                'Rakan Alshareef',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font14Bold(),
              ),
              subtitle: Text(
                "Last Message Sent",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font12SemiBold(
                    color: ColorManager.hintTextColor),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '● Admin',
                  style: StyleManager.font12SemiBold(color: ColorManager.blueColor),
                ),
                verticalSpace(20.h),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'just Now',
                  style: StyleManager.font12Regular(
                      color: ColorManager.blackColor.withOpacity(.75)),
                ),
                verticalSpace(10.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Badge.count(
                    count: 3,
                    backgroundColor: ColorManager.errorColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
