import 'package:admin/screens/notification/provider/notification_provider.dart';
import 'package:provider/provider.dart';

import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_text_field.dart';

class SendNotificationForm extends StatelessWidget {
  const SendNotificationForm({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: context.read<NotificationProvider>().sendNotificationFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF012437), Color(0xFF4A934A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              CustomTextField(
                controller: context.read<NotificationProvider>().titleCtrl,
                labelText: 'Enter Notification Title ....',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Title name';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller:
                    context.read<NotificationProvider>().descriptionCtrl,
                labelText: 'Enter Notification Description ....',
                lineNumber: 3,
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description ';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.read<NotificationProvider>().imageUrlCtrl,
                labelText: 'Enter Notification Image Url ....',
                onSave: (val) {},
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // foreground
                    ),
                    onPressed: () {
                      // Validate and save the form
                      final form = context
                          .read<NotificationProvider>()
                          .sendNotificationFormKey
                          .currentState;
                      if (form != null && form.validate()) {
                        form.save();
                        context.read<NotificationProvider>().sendNotification();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the popup
void sendNotificationForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Send Notification'.toUpperCase(),
            style: TextStyle(color: primaryColor),
          ),
        ),
        content: SendNotificationForm(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.transparent,
      );
    },
  );
}
