import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/constants_widgets.dart';

class LauncherHelper {
  static void launchPhone(String number) async {
    final Uri phoneLaunchUri = Uri.parse("tel:$number");

    if (await canLaunchUrl(phoneLaunchUri)) {
     await launchUrl(
        phoneLaunchUri,
      );
    }
  }
  static void launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
    );
    if (await canLaunchUrl(emailLaunchUri)) {
     await launchUrl(
       emailLaunchUri,
      );
    }
  }

  static Future<void> launchWebsite(BuildContext context,String url) async {
    try {
      final Uri websiteLaunchUri = Uri.parse(url);
      print(url);
      if (await canLaunchUrl(websiteLaunchUri)) {
        ConstantsWidgets.showLoading();
        await launchUrl(
          websiteLaunchUri,
          mode: LaunchMode.externalApplication,
        );
        ConstantsWidgets.closeDialog();
      } else {
        // LoadingDialog.hide(context);
        throw 'Could not launch $url';
      }
    } catch (e) {
      // LoadingDialog.hide(context);
      print('Error launching URL: $e');
      rethrow;
    }
  }



}
