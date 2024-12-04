import 'package:animate_do/animate_do.dart';
import 'package:enjaz_app/app/features/project_details/widgets/reports_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/const_value_manager.dart';
import '../widgets/assets_item_widget.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

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
          return ReportsItemWidget(
              image: item.image,
            name: 'Omar Alrefaee',
            date: DateFormat.yMd().add_jm().format(DateTime.now()),
          );
        },
        itemCount: ConstValueManager.assetsList.length,
        separatorBuilder: (_,__)=>verticalSpace(20.h),
      ),
    );
  }
}
