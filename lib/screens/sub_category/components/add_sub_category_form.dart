import 'package:admin/core/data/data_provider.dart';

import '../../../models/sub_category.dart';
import '../provider/sub_category_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class SubCategorySubmitForm extends StatelessWidget {
  final SubCategory? subCategory;

  const SubCategorySubmitForm({Key? key, this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<SubCategoryProvider>()
        .setDataForUpdateSubCategory(subCategory);
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: context.read<SubCategoryProvider>().addSubCategoryFormKey,
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
                    child: Consumer<SubCategoryProvider>(
                      builder: (context, subCatProvider, child) {
                        return CustomDropdown(
                          initialValue: subCatProvider.selectedCategory,
                          hintText: subCatProvider.selectedCategory?.name ??
                              'Select category',
                          items: context.read<DataProvider>().categories,
                          displayItem: (Category? category) =>
                              category?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              subCatProvider.selectedCategory = newValue;
                              subCatProvider.updateUi();
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context
                          .read<SubCategoryProvider>()
                          .subCategoryNameCtrl,
                      labelText: 'Sub Category Name',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a sub category name';
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
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // foreground
                    ),
                    onPressed: () {
                      // Validate and save the form
                      final form = context
                          .read<SubCategoryProvider>()
                          .addSubCategoryFormKey
                          .currentState;
                      if (form != null && form.validate()) {
                        form.save();
                        context.read<SubCategoryProvider>().submitSubCategory();
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

// How to show the category popup
void showAddSubCategoryForm(BuildContext context, SubCategory? subCategory) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text('Add Sub Category'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: SubCategorySubmitForm(subCategory: subCategory),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.transparent,
      );
    },
  );
}
