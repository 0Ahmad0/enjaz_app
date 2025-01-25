import 'dart:io';

import 'package:enjaz_app/app/features/progress_pictures/screens/pick_images_progrees_screen.dart';
import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProgressPictureScreen extends StatefulWidget {
  const ProgressPictureScreen({super.key});

  @override
  State<ProgressPictureScreen> createState() => _ProgressPictureScreenState();
}

class _ProgressPictureScreenState extends State<ProgressPictureScreen> {
  final List _projects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(StringManager.progressPictureText),
      ),
      body: !_projects.isEmpty
          ? Center(
              child: Text('No Projects Yet'),
            )
          : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0.0,
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_)=> PickImageProgreesScreen()
                      ));
                    },
                    title: Text('Project Name${++index}'),
                    trailing: Icon(Icons.navigate_next_rounded),
                  ),
                );
              },
            ),
    );
  }
}
