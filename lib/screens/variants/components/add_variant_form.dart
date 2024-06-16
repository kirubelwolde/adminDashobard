import 'package:admin/core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/variant.dart';
import '../../../models/variant_type.dart';
import '../provider/variant_provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class VariantSubmitForm extends StatelessWidget {
  final Variant? variant;

  const VariantSubmitForm({Key? key, this.variant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<VariantsProvider>().setDataForUpdateVariant(variant);
    return SingleChildScrollView(
      child: Form(
        key: context.read<VariantsProvider>().addVariantsFormKey,
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
                    child: Consumer<VariantsProvider>(
                      builder: (context, variantProvider, child) {
                        return CustomDropdown(
                          initialValue: variantProvider.selectedVariantType,
                          items: context.watch<DataProvider>().variantTypes,
                          hintText: variantProvider.selectedVariantType?.name ??
                              'Select Variant Type',
                          displayItem: (VariantType? variantType) =>
                              variantType?.name ?? '',
                          onChanged: (newValue) {
                            variantProvider.selectedVariantType = newValue;
                            variantProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Variant Type';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.read<VariantsProvider>().variantCtrl,
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
                      if (context
                          .read<VariantsProvider>()
                          .addVariantsFormKey
                          .currentState!
                          .validate()) {
                        context
                            .read<VariantsProvider>()
                            .addVariantsFormKey
                            .currentState!
                            .save();
                        context.read<VariantsProvider>().submitVariant();
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

// How to show the variant popup
void showAddVariantForm(BuildContext context, Variant? variant) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text('Add Variant'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: VariantSubmitForm(variant: variant),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      );
    },
  );
}
