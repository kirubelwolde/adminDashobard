import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/variant_type.dart';
import '../provider/variant_type_provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_text_field.dart';

class VariantTypeSubmitForm extends StatelessWidget {
  final VariantType? variantType;

  const VariantTypeSubmitForm({Key? key, this.variantType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.variantTypeProvider.setDataForUpdateVariantTYpe(variantType);
    return SingleChildScrollView(
      child: Form(
        key: context.variantTypeProvider.addVariantsTypeFormKey,
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.variantTypeProvider.variantNameCtrl,
                      labelText: 'Variant Name',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a variant name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.variantTypeProvider.variantTypeCtrl,
                      labelText: 'Variant Type',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a type name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
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
                      if (context.variantTypeProvider.addVariantsTypeFormKey
                          .currentState!
                          .validate()) {
                        context.variantTypeProvider.addVariantsTypeFormKey
                            .currentState!
                            .save();
                        context.variantTypeProvider.submitVariantType();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
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

// How to show the variant type popup
void showAddVariantsTypeForm(BuildContext context, VariantType? variantType) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text('Add Variant Type'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: VariantTypeSubmitForm(variantType: variantType),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      );
    },
  );
}
