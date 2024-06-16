import '../../../models/product.dart';
import '../../../models/event.dart';
import '../../../models/sub_category.dart';
import '../provider/coupon_code_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import '../../../models/coupon.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class CouponSubmitForm extends StatelessWidget {
  final Coupon? coupon;

  const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.couponCodeProvider.setDataForUpdateCoupon(coupon);
    return SingleChildScrollView(
      child: Form(
        key: context.couponCodeProvider.addCouponFormKey,
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
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.couponCodeProvider.couponCodeCtrl,
                      labelText: 'Coupon Code',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter coupon code';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown<String>(
                      key: GlobalKey(),
                      hintText: 'Discount Type',
                      items: ['fixed', 'percentage'],
                      initialValue:
                          context.couponCodeProvider.selectedDiscountType,
                      onChanged: (newValue) {
                        context.couponCodeProvider.selectedDiscountType =
                            newValue ?? 'fixed';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a discount type';
                        }
                        return null;
                      },
                      displayItem: (val) => val,
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.couponCodeProvider.discountAmountCtrl,
                      labelText: 'Discount Amount',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter discount amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller:
                          context.couponCodeProvider.minimumPurchaseAmountCtrl,
                      labelText: 'Minimum Purchase Amount',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter minimum purchase amount';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      labelText: 'Select Date',
                      controller: context.couponCodeProvider.endDateCtrl,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateSelected: (DateTime date) {
                        print('Selected Date: $date');
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown<String>(
                      key: GlobalKey(),
                      hintText: 'Status',
                      initialValue:
                          context.couponCodeProvider.selectedCouponStatus,
                      items: ['active', 'inactive'],
                      displayItem: (val) => val,
                      onChanged: (newValue) {
                        context.couponCodeProvider.selectedCouponStatus =
                            newValue ?? 'active';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select status';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown<Category?>(
                          initialValue: couponProvider.selectedCategory,
                          hintText: couponProvider.selectedCategory?.name ??
                              'Select category',
                          items: context.dataProvider.categories,
                          displayItem: (Category? category) =>
                              category?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedCategory = newValue;
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.selectedEvent = null;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown<SubCategory?>(
                          initialValue: couponProvider.selectedSubCategory,
                          hintText: couponProvider.selectedSubCategory?.name ??
                              'Select sub category',
                          items: context.dataProvider.subCategories,
                          displayItem: (SubCategory? subCategory) =>
                              subCategory?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedSubCategory = newValue;
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.selectedEvent = null;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown<Product?>(
                          initialValue: couponProvider.selectedProduct,
                          hintText: couponProvider.selectedProduct?.name ??
                              'Select product',
                          items: context.dataProvider.products,
                          displayItem: (Product? product) =>
                              product?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedProduct = newValue;
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedEvent = null;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown<Event?>(
                          initialValue: couponProvider.selectedEvent,
                          hintText: couponProvider.selectedEvent?.name ??
                              'Select event',
                          items: context.dataProvider.events,
                          displayItem: (Event? event) => event?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedEvent = newValue;
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGradientButton(context, 'Cancel', () {
                    Navigator.of(context).pop(); // Close the popup
                  }),
                  SizedBox(width: defaultPadding),
                  _buildGradientButton(context, 'Submit', () {
                    // Validate and save the form
                    if (context
                        .couponCodeProvider.addCouponFormKey.currentState!
                        .validate()) {
                      context.couponCodeProvider.addCouponFormKey.currentState!
                          .save();
                      context.couponCodeProvider.submitCoupon();
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

// How to show the coupon popup
void showAddCouponForm(BuildContext context, Coupon? coupon) {
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
                    'Add Coupon'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CouponSubmitForm(coupon: coupon),
            ],
          ),
        ),
      );
    },
  );
}
