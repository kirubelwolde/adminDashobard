import '../../../models/sub_category.dart';
import '../provider/brand_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/brand.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class BrandSubmitForm extends StatelessWidget {
  final Brand? brand;

  const BrandSubmitForm({super.key, this.brand});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.brandProvider.setDataForUpdateBrand(brand);
    return SingleChildScrollView(
      child: Form(
        key: context.brandProvider.addBrandFormKey,
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
              Row(
                children: [
                  Expanded(
                    child: Consumer<BrandProvider>(
                      builder: (context, brandProvider, child) {
                        return CustomDropdown(
                          initialValue: brandProvider.selectedSubCategory,
                          items: context.dataProvider.subCategories,
                          hintText: brandProvider.selectedSubCategory?.name ??
                              'Select Sub Category',
                          displayItem: (SubCategory? subCategory) =>
                              subCategory?.name ?? '',
                          onChanged: (newValue) {
                            brandProvider.selectedSubCategory = newValue;
                            brandProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Sub Category';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.brandProvider.brandNameCtrl,
                      labelText: 'Brand Name',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a brand name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGradientButton(context, 'Cancel', () {
                    Navigator.of(context).pop(); // Close the popup
                  }),
                  Gap(defaultPadding),
                  _buildGradientButton(context, 'Submit', () {
                    // Validate and save the form
                    if (context.brandProvider.addBrandFormKey.currentState!
                        .validate()) {
                      context.brandProvider.addBrandFormKey.currentState!
                          .save();
                      context.brandProvider.submitBrand();
                      Navigator.of(context).pop();
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ).copyWith(
        elevation: ButtonStyleButton.allOrNull(0.0),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF012437), Color(0xFF4A934A)]),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(text),
        ),
      ),
    );
  }
}

// How to show the category popup
void showBrandForm(BuildContext context, Brand? brand) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Add Brand'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              BrandSubmitForm(brand: brand),
            ],
          ),
        ),
      );
    },
  );
}
