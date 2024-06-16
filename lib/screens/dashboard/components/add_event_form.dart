import 'package:admin/core/data/data_provider.dart';

import '../../../models/brand.dart';
import '../../../models/category.dart';
import '../../../models/event.dart';
import '../../../models/sub_category.dart';
import '../../../models/variant_type.dart';
import '../provider/dash_board_provider.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/multi_select_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/event_image_card.dart';

class EventSubmitForm extends StatelessWidget {
  final Event? event;

  const EventSubmitForm({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<DashBoardProvider>().setDataForUpdateEvent(event);
    return SingleChildScrollView(
      child: Form(
        key: context.read<DashBoardProvider>().addEventFormKey,
        child: Container(
          width: size.width * 0.7,
          padding: EdgeInsets.all(defaultPadding),
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
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return EventImageCard(
                        labelText: 'Main Image',
                        imageFile: dashProvider.selectedMainImage,
                        imageUrlForUpdateImage:
                            event?.images.safeElementAt(0)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 1);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedMainImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return EventImageCard(
                        labelText: 'Second image',
                        imageFile: dashProvider.selectedSecondImage,
                        imageUrlForUpdateImage:
                            event?.images.safeElementAt(1)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 2);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedSecondImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return EventImageCard(
                        labelText: 'Third image',
                        imageFile: dashProvider.selectedThirdImage,
                        imageUrlForUpdateImage:
                            event?.images.safeElementAt(2)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 3);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedThirdImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return EventImageCard(
                        labelText: 'Fourth image',
                        imageFile: dashProvider.selectedFourthImage,
                        imageUrlForUpdateImage:
                            event?.images.safeElementAt(3)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 4);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedFourthImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return EventImageCard(
                        labelText: 'Fifth image',
                        imageFile: dashProvider.selectedFifthImage,
                        imageUrlForUpdateImage:
                            event?.images.safeElementAt(4)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 5);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedFifthImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              CustomTextField(
                controller: context.read<DashBoardProvider>().eventNameCtrl,
                labelText: 'Event Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: defaultPadding),
              CustomTextField(
                controller: context.read<DashBoardProvider>().eventDescCtrl,
                labelText: 'Event Description',
                lineNumber: 3,
                onSave: (val) {},
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return CustomDropdown<Category?>(
                          key: ValueKey(dashProvider.selectedCategory?.sId),
                          initialValue: dashProvider.selectedCategory,
                          hintText: dashProvider.selectedCategory?.name ??
                              'Select category',
                          items: context.read<DataProvider>().categories,
                          displayItem: (Category? category) =>
                              category?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              context
                                  .read<DashBoardProvider>()
                                  .filterSubcategory(newValue);
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
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return CustomDropdown<SubCategory?>(
                          key: ValueKey(dashProvider.selectedSubCategory?.sId),
                          hintText: dashProvider.selectedSubCategory?.name ??
                              'Sub category',
                          items: dashProvider.subCategoriesByCategory,
                          initialValue: dashProvider.selectedSubCategory,
                          displayItem: (SubCategory? subCategory) =>
                              subCategory?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              context
                                  .read<DashBoardProvider>()
                                  .filterBrand(newValue);
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select sub category';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return CustomDropdown<Brand?>(
                            key: ValueKey(dashProvider.selectedBrand?.sId),
                            initialValue: dashProvider.selectedBrand,
                            items: dashProvider.brandsBySubCategory,
                            hintText: dashProvider.selectedBrand?.name ??
                                'Select Brand',
                            displayItem: (Brand? brand) => brand?.name ?? '',
                            onChanged: (newValue) {
                              if (newValue != null) {
                                dashProvider.selectedBrand = newValue;
                                dashProvider.updateUI();
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please brand';
                              }
                              return null;
                            });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller:
                          context.read<DashBoardProvider>().eventPriceCtrl,
                      labelText: 'Price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller:
                          context.read<DashBoardProvider>().eventOffPriceCtrl,
                      labelText: 'Offer price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller:
                          context.read<DashBoardProvider>().eventQntCtrl,
                      labelText: 'Quantity',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return CustomDropdown<VariantType?>(
                          key: ValueKey(dashProvider.selectedVariantType?.sId),
                          initialValue: dashProvider.selectedVariantType,
                          items: context.read<DataProvider>().variantTypes,
                          displayItem: (VariantType? variantType) =>
                              variantType?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              context
                                  .read<DashBoardProvider>()
                                  .filterVariant(newValue);
                            }
                          },
                          hintText: 'Select Variant type',
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        final filteredSelectedItems = dashProvider
                            .selectedVariants
                            .where((item) => dashProvider.variantsByVariantType
                                .contains(item))
                            .toList();
                        return MultiSelectDropDown(
                          items: dashProvider.variantsByVariantType,
                          onSelectionChanged: (newValue) {
                            dashProvider.selectedVariants = newValue;
                            dashProvider.updateUI();
                          },
                          displayItem: (String item) => item,
                          selectedItems: filteredSelectedItems,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
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
                      final form = context
                          .read<DashBoardProvider>()
                          .addEventFormKey
                          .currentState;
                      if (form != null && form.validate()) {
                        form.save();
                        context.read<DashBoardProvider>().submitEvent();
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

// How to show the popup
void showAddEventForm(BuildContext context, Event? event) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Add Event'.toUpperCase(),
            style: TextStyle(color: primaryColor),
          ),
        ),
        content: EventSubmitForm(event: event),
      );
    },
  );
}

extension SafeList<T> on List<T>? {
  T? safeElementAt(int index) {
    // Check if the list is null or if the index is out of range
    if (this == null || index < 0 || index >= this!.length) {
      return null;
    }
    return this![index];
  }
}
