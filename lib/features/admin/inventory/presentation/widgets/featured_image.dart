import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/util/widget/custom_bottom_sheet.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 18:32:44

class FeaturedImage extends StatelessWidget {
  final ValueNotifier<File?> featuredImage;

  const FeaturedImage({super.key, required this.featuredImage});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: featuredImage,
      builder: (ctx, image, child) {
        return Container(
          padding: EdgeInsets.all(image == null ? 20.0 : 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 1, color: Colors.grey)),
          child: image == null
              ? child!
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 150.0,
                    ),
                    TextButton(
                      onPressed: () => featuredImage.value = null,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text("Remove"),
                    )
                  ],
                ),
        );
      },
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Please upload an image for the product feature",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              CustomBottomSheet.showImagePickerDialog(
                context: context,
                title: "Upload",
                subtitle: "Choose your upload option",
                onTakePhoto: () async {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    featuredImage.value = File(image.path);
                  }
                },
                onChoosePhoto: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    featuredImage.value = File(image.path);
                  }
                },
              );
            },
            child: const Text("Upload"),
          )
        ],
      ),
    );
  }
}
