import '../provider/poster_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/poster.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class PosterSubmitForm extends StatelessWidget {
  final Poster? poster;

  const PosterSubmitForm({super.key, this.poster});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.posterProvider.setDataForUpdatePoster(poster);
    return SingleChildScrollView(
      child: Form(
        key: context.posterProvider.addPosterFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
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
              Consumer<PosterProvider>(
                builder: (context, posterProvider, child) {
                  return CategoryImageCard(
                    labelText: "Poster",
                    imageFile: posterProvider.selectedImage,
                    imageUrlForUpdateImage: poster?.imageUrl,
                    onTap: () {
                      posterProvider.pickImage();
                    },
                  );
                },
              ),
              Gap(defaultPadding),
              CustomTextField(
                controller: context.posterProvider.posterNameCtrl,
                labelText: 'Poster Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a poster name';
                  }
                  return null;
                },
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF012437), Color(0xFF4A934A)]),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(minHeight: 36),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Cancel'),
                      ),
                    ),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.posterProvider.addPosterFormKey.currentState!
                          .validate()) {
                        context.posterProvider.addPosterFormKey.currentState!
                            .save();
                        context.posterProvider.submitPoster();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF012437), Color(0xFF4A934A)]),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(minHeight: 36),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Submit'),
                      ),
                    ),
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
void showAddPosterForm(BuildContext context, Poster? poster) {
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
                    'Add Poster'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              PosterSubmitForm(poster: poster),
            ],
          ),
        ),
      );
    },
  );
}
