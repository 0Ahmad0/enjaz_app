


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/enums.dart';

IconData getFileIcon(String? type) {
  switch (TypeFile.values.where((element) => element.name == type).firstOrNull) {
    case TypeFile.image:
      return Icons.image;
    case TypeFile.audio:
      return Icons.audiotrack;
    case TypeFile.file:
    default:
      return Icons.insert_drive_file;
  }
}

TypeFile getFileType(String? filePath) {
  // استخراج الامتداد من مسار الملف
  String? extension = filePath?.split('.').last.toLowerCase();

  switch (extension) {
    case 'txt':
    case 'doc':
    case 'docx':
    case 'pdf':
      return TypeFile.file;
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
      return TypeFile.image;
    case 'mp3':
    case 'wav':
      return TypeFile.audio;
    default:
      return TypeFile.file; // أي نوع آخر يعتبر ملفًا عامًا
  }
}

String formatFileSize(int? size) {
  if (size == null) return "Undefined";
  if (size < 1024) return "$size Byte";
  if (size < 1024 * 1024) return "${(size / 1024).toStringAsFixed(0)} KB";
  if (size < 1024 * 1024 * 1024) return "${(size / (1024 * 1024)).toStringAsFixed(0)} MB";
  return "${(size / (1024 * 1024 * 1024)).toStringAsFixed(0)} GB";
}
// String formatFileSize(int fileSize) {
//   double b = fileSize / 1;
//   double kb = fileSize / 1024;
//   double mb = kb / 1024;
//   double gb = mb / 1024;
//
//   if (gb >= 1) {
//     return '${gb.toStringAsFixed(2)} ${tr(LocaleKeys.GB)}';//GB';
//   } else if (mb >= 1) {
//     return '${mb.toStringAsFixed(2)} ${tr(LocaleKeys.MB)}';//MB';
//   } else if (kb >= 1) {
//     return '${kb.toStringAsFixed(2)} ${tr(LocaleKeys.KB)}';//KB';
//   } else {
//     return '${b.toString()} ${tr(LocaleKeys.B)}';//B';
//   }
// }


// void openUrl({required String path}) async {
//   // Replace the URL with your own PDF file URL
//   final url = Uri.parse(path);
//   if (await canLaunchUrl(url) ) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// void openPdf({required String path}) async {
//   // Replace the URL with your own PDF file URL
//   final url = Uri.parse(path);
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

