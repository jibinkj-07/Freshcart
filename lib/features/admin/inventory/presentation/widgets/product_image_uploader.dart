import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/util/widget/custom_bottom_sheet.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 17:02:44

class ProductImageUploader extends StatelessWidget {
  final ValueNotifier<List<File>> images;

  const ProductImageUploader({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: images,
      builder: (ctx, imageList, _) {
        return Container(
          padding: EdgeInsets.all(imageList.isEmpty ? 20.0 : 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(width: 1, color: Colors.grey)),
          child: Column(
            children: [
              imageList.isEmpty
                  ? const Text(
                      "Please upload images related to the product.",
                      style: TextStyle(color: Colors.grey),
                    )
                  : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imageList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: .7 / 1),
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: Image.file(
                              imageList[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _deleteImage(imageList[index]),
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red),
                            child: const Text("Remove"),
                          )
                        ],
                      );
                    },
                  ),
              TextButton(
                onPressed: () {
                  CustomBottomSheet.showImagePickerDialog(
                    context: context,
                    title: "Upload",
                    subtitle: "Choose your upload option",
                    onTakePhoto: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image != null) {
                        _addImage(image);
                      }
                    },
                    onChoosePhoto: () async {
                      final image = await ImagePicker().pickMultiImage();
                      for (final img in image) {
                        _addImage(img);
                      }
                    },
                  );
                },
                child: const Text("Upload"),
              )
            ],
          ),
        );
      },
    );
  }

  void _addImage(XFile image) {
    images.value = [...images.value, File(image.path)];
  }

  void _deleteImage(File image) {
    images.value = images.value.where((item) => item != image).toList();
  }
}
