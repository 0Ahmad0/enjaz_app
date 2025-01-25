import 'dart:io';

import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/utils/style_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageProgreesScreen extends StatefulWidget {
  const PickImageProgreesScreen({super.key});

  @override
  State<PickImageProgreesScreen> createState() => _PickImageProgreesScreenState();
}

class _PickImageProgreesScreenState extends State<PickImageProgreesScreen> {
  final ImagePicker _picker = ImagePicker();
  Map<String, List<File>> _groupedImages = {};

  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        String today = DateTime.now().toIso8601String().split('T')[0];
        if (!_groupedImages.containsKey(today)) {
          _groupedImages[today] = [];
        }
        _groupedImages[today]!.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(StringManager.progressPictureText),
        actions: [
          IconButton(
            onPressed: pickImages,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: _groupedImages.isEmpty ? Center()
          :
      ListView.separated(
        itemCount: _groupedImages.keys.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          String date = _groupedImages.keys.elementAt(index);
          List<File> images = _groupedImages[date]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.file(
                        image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),

    );
  }
}
