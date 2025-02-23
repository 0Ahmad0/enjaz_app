import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Date Formatting

class KeyCodeDialogWidget extends StatefulWidget {
  final Function() onKeyCodeValid;

  KeyCodeDialogWidget({required this.onKeyCodeValid});

  @override
  _KeyCodeDialogWidgetState createState() => _KeyCodeDialogWidgetState();
}

class _KeyCodeDialogWidgetState extends State<KeyCodeDialogWidget> {
  final _keyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String getCurrentKey() {
    DateTime now = DateTime.now();
    int day = now.day; // Day
    int month = now.month; // Month
    return '$day$month'; // Code based on month and day
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter the key'),
      // title: Text('أدخل الكود'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _keyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter the key here"),
              // decoration: InputDecoration(hintText: "ادخل الكود هنا"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the key';
                }
                if (value != getCurrentKey()) {
                  return 'Incorrect key';
                }
                return null;
              },
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'من فضلك أدخل الكود';
              //   }
              //   if (value != getCurrentKey()) {
              //     return 'الكود غير صحيح';
              //   }
              //   return null;
              // },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop();
              widget.onKeyCodeValid();

            }
          },
          child: Text('Validate'),
  // child: Text('تحقق'),
        ),
      ],
    );
  }
}