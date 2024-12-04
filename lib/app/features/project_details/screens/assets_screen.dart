import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/auth/screens/change_password_screen.dart';
import 'package:enjaz_app/core/helpers/spacing.dart';
import 'package:enjaz_app/core/utils/const_value_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/assets_item_widget.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h
        ),
        itemBuilder: (context, index) {
          final item = ConstValueManager.assetsList[index];
          return AssetsItemWidget(
            image: item.image,
            title: item.title,
            quantity: item.quantity,
            cost: item.cost,
            total: item.total
        );
        },
        itemCount: ConstValueManager.assetsList.length,
        separatorBuilder: (_,__)=>verticalSpace(20.h),
      ),
    );
  }
}
