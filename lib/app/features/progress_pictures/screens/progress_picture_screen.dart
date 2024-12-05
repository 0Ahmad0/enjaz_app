import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';

class ProgressPictureScreen extends StatelessWidget {
  const ProgressPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(StringManager.progressPictureText),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
    );
  }
}
