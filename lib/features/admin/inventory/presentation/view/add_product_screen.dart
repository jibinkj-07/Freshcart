import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_cart/features/admin/inventory/data/model/product_model.dart';
import '../../../../../core/config/config_helper.dart';
import '../../../../../core/config/route/route_mapper.dart';
import '../../../../../core/util/widget/animated_loading_button.dart';
import '../../../../../core/util/widget/custom_snackbar.dart';
import '../../../../../core/util/widget/outlined_text_field.dart';
import '../../data/model/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/featured_image.dart';
import '../widgets/product_image_uploader.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 13:52:00

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<CategoryModel?> _selectedCategory = ValueNotifier(null);
  final ValueNotifier<List<File>> _images = ValueNotifier([]);
  final ValueNotifier<File?> _featuredImage = ValueNotifier(null);
  String _name = "";
  String _description = "";
  int _quantity = 0;
  double _price = 0.0;
  double _salesPrice = 0.0;

  @override
  void dispose() {
    _images.dispose();
    _featuredImage.dispose();
    _selectedCategory.dispose();
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            OutlinedTextField(
              textFieldKey: "name",
              isObscure: false,
              hintText: "Name",
              inputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: (data) {
                if (data.toString().trim().isEmpty) {
                  return "Name is empty";
                }
                return null;
              },
              onSaved: (data) => _name = data.toString().trim(),
            ),
            const SizedBox(height: 20.0),
            OutlinedTextField(
              textFieldKey: "description",
              isObscure: false,
              minLines: 1,
              maxLines: 5,
              hintText: "Description [Optional]",
              inputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              onSaved: (data) => _description = data.toString().trim(),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<CategoryBloc, CategoryState>(builder: (ctx, state) {
              if (state.category.isEmpty) {
                return TextButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed(
                          RouteMapper.addCategoryScreen,
                        ),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text("Create category"));
              }
              return DropdownButtonFormField<CategoryModel>(
                borderRadius: BorderRadius.circular(20.0),
                style: TextStyle(
                  fontSize: 15.0,
                  color: Theme.of(context).primaryColor,
                  fontFamily: ConfigHelper.fontFamily,
                ),
                decoration: InputDecoration(
                  hintText: 'Please select a category',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelText: "Category",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  contentPadding: const EdgeInsets.all(15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: ConfigHelper.appColor,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                items: state.category.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.title),
                  );
                }).toList(),
                onChanged: (CategoryModel? newValue) =>
                    _selectedCategory.value = newValue,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              );
            }),
            const SizedBox(height: 20.0),
            OutlinedTextField(
              textFieldKey: "quantity",
              isObscure: false,
              hintText: "Quantity",
              inputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              inputType: TextInputType.number,
              validator: (data) {
                final value = data.toString().trim();
                if (value.isEmpty) {
                  return "Quantity is missing";
                } else if (!_isNumeric(value)) {
                  return "Invalid format";
                }
                return null;
              },
              onSaved: (data) => _quantity = int.parse(data.toString().trim()),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: OutlinedTextField(
                    textFieldKey: "price",
                    isObscure: false,
                    hintText: "Price",
                    inputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.number,
                    validator: (data) {
                      final value = data.toString().trim();
                      if (value.isEmpty) {
                        return "Price is missing";
                      } else if (!_isDouble(value)) {
                        return "Invalid format";
                      }
                      return null;
                    },
                    onSaved: (data) =>
                        _price = double.parse(data.toString().trim()),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedTextField(
                    textFieldKey: "salesPrice",
                    isObscure: false,
                    hintText: "Sales Price",
                    inputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.number,
                    validator: (data) {
                      final value = data.toString().trim();
                      if (value.isEmpty) {
                        return "Sales price is missing";
                      } else if (!_isDouble(value)) {
                        return "Invalid format";
                      }
                      return null;
                    },
                    onSaved: (data) =>
                        _salesPrice = double.parse(data.toString().trim()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            FeaturedImage(featuredImage: _featuredImage),
            const SizedBox(height: 20.0),
            ProductImageUploader(images: _images),
            const SizedBox(height: 30.0),
            BlocListener<ProductBloc, ProductState>(
              listener: (ctx, state) {
                _loading.value = state.status == ProductStatus.adding;
                if (state.error != null) {
                  state.error!.showSnackBar(context);
                }
                if (state.status == ProductStatus.added) {
                  Navigator.pop(context);
                }
              },
              child: ValueListenableBuilder(
                valueListenable: _loading,
                builder: (ctx, loading, _) {
                  return AnimatedLoadingButton(
                    onPressed: _onAdd,
                    loading: loading,
                    child: const Text("Add"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAdd() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      if (_featuredImage.value == null) {
        CustomSnackBar.showErrorSnackBar(
            context, "Please upload a feature image");
        return;
      }
      if (_images.value.isEmpty) {
        CustomSnackBar.showErrorSnackBar(
          context,
          "Please upload at least one image related to this product",
        );
        return;
      }
      final product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _name,
        description: _description,
        quantity: _quantity,
        category: _selectedCategory.value!,
        featuredImage: "",
        price: _price,
        salePrice: _salesPrice,
        comments: [],
        images: [],
      );
      context.read<ProductBloc>().add(
            AddProduct(
              product: product,
              images: _images.value,
              featuredImage: _featuredImage.value!,
            ),
          );
    }
  }

  bool _isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  bool _isDouble(String s) {
    if (s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
