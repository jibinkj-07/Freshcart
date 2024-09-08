import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/config/app_config.dart';
import '../../../../../core/config/route/route_mapper.dart';
import '../../../../../core/util/widget/animated_loading_button.dart';
import '../../../../../core/util/widget/custom_snackbar.dart';
import '../../../../../core/util/widget/outlined_text_field.dart';
import '../../data/model/category_model.dart';
import '../../data/model/product_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/product_bloc.dart';
import '../view_model/inventory_helper.dart';
import '../widgets/featured_image.dart';
import '../widgets/product_image_uploader.dart';

/// @author : Jibin K John
/// @date   : 22/08/2024
/// @time   : 13:52:00

class AddProductScreen extends StatefulWidget {
  final ProductModel? product;

  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<CategoryModel?> _selectedCategory = ValueNotifier(null);
  final ValueNotifier<List<File>> _images = ValueNotifier([]);
  final ValueNotifier<File?> _featuredImage = ValueNotifier(null);
  final TextEditingController _expiryController = TextEditingController();
  DateTime _expiry = DateTime.now().add(const Duration(days: 1));

  final ValueNotifier<bool> _expiryNotApplicable = ValueNotifier(false);
  String _name = "";
  String _description = "";
  int _quantity = 0;
  double _price = 0.0;
  double _salesPrice = 0.0;
  int _offer = 0;

  @override
  void initState() {
    _expiryController.text = _dateFormatter(_expiry);
    _initProduct(widget.product);
    super.initState();
  }

  @override
  void dispose() {
    _images.dispose();
    _featuredImage.dispose();
    _selectedCategory.dispose();
    _loading.dispose();
    _expiryNotApplicable.dispose();
    _expiryController.dispose();
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
        title: Text(widget.product == null ? "Add Product" : "Update Product"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            OutlinedTextField(
              textFieldKey: "name",
              initialValue: widget.product?.name,
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
              initialValue: widget.product?.description,
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
              CategoryModel? category;
              if (state.category.isEmpty) {
                return TextButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed(
                          RouteMapper.addCategoryScreen,
                        ),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text("Create category"));
              }
              if (widget.product != null) {
                category = state.category.firstWhere(
                  (item) => item.id == widget.product!.category.id,
                );
              }
              return DropdownButtonFormField<CategoryModel>(
                value: category,
                borderRadius: BorderRadius.circular(20.0),
                style: TextStyle(
                  fontSize: 15.0,
                  color: Theme.of(context).primaryColor,
                  fontFamily: AppConfig.fontFamily,
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
                      color: AppConfig.appColor,
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
            Row(
              children: [
                Expanded(
                  child: OutlinedTextField(
                    textFieldKey: "quantity",
                    initialValue: widget.product?.quantity.toString(),
                    isObscure: false,
                    hintText: "Quantity",
                    inputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.number,
                    maxLength: 6,
                    validator: (data) {
                      final value = data.toString().trim();
                      if (value.isEmpty) {
                        return "Quantity is missing";
                      } else if (!_isNumeric(value)) {
                        return "Invalid format";
                      }
                      return null;
                    },
                    onSaved: (data) =>
                        _quantity = int.parse(data.toString().trim()),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedTextField(
                    textFieldKey: "offer",
                    initialValue: widget.product?.offerPercentage.toString(),
                    isObscure: false,
                    hintText: "Offer in percentage",
                    inputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    inputType: TextInputType.number,
                    maxLength: 3,
                    validator: (data) {
                      final value = data.toString().trim();
                      if (!_isNumeric(value)) {
                        return "Invalid format";
                      } else if (int.parse(value) > 100) {
                        return "Must be less than 100";
                      }
                      return null;
                    },
                    onSaved: (data) =>
                        _offer = int.parse(data.toString().trim()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: OutlinedTextField(
                    textFieldKey: "price",
                    initialValue: widget.product?.price.toString(),
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
                    initialValue: widget.product?.salePrice.toString(),
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
            ValueListenableBuilder(
                valueListenable: _expiryNotApplicable,
                builder: (ctx, isExpiry, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedTextField(
                          readOnly: true,
                          enabled: !isExpiry,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              initialDate: _expiry,
                              lastDate: DateTime(2900),
                            );
                            if (date != null) {
                              _expiryController.text = _dateFormatter(date);
                              _expiry = date;
                            }
                          },
                          controller: _expiryController,
                          textFieldKey: "expiry",
                          isObscure: false,
                          hintText: "Expiry Date",
                          inputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          validator: (data) {
                            final value = data.toString().trim();
                            if (value.isEmpty && _expiryNotApplicable.value) {
                              return "Expiry date is missing";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Checkbox(
                        value: isExpiry,
                        onChanged: (value) =>
                            _expiryNotApplicable.value = value ?? false,
                      ),
                      const Text("Not applicable")
                    ],
                  );
                }),
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
                    child: Text(widget.product == null ? "Add" : "Update"),
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
        id: widget.product != null
            ? widget.product!.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        name: _name,
        description: _description,
        quantity: _quantity,
        category: _selectedCategory.value!,
        featuredImage: "",
        price: _price,
        salePrice: _salesPrice,
        comments: widget.product != null ? widget.product!.comments : [],
        images: [],
        expiry: _expiryNotApplicable.value ? null : _expiry,
        offerPercentage: _offer,
      );
      if (widget.product != null) {
        context.read<ProductBloc>().add(UpdateProduct(
              product: product,
              images: _images.value,
              featuredImage: _featuredImage.value!,
            ));
      } else {
        context.read<ProductBloc>().add(
              AddProduct(
                product: product,
                images: _images.value,
                featuredImage: _featuredImage.value!,
              ),
            );
      }
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

  String _dateFormatter(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }

  Future<void> _initProduct(ProductModel? product) async {
    if (product != null) {
      List<File> images = [];
      for (final image in product.images) {
        images.add(await InventoryHelper.urlToFile(image));
      }
      _images.value = images;
      _featuredImage.value =
          await InventoryHelper.urlToFile(product.featuredImage);
      _selectedCategory.value = product.category;
      if (product.expiry != null) {
        _expiry = product.expiry!;
      } else {
        _expiryNotApplicable.value = true;
      }
      _expiryController.text = _dateFormatter(_expiry);
      _name = product.name;
      _description = product.description;
      _quantity = product.quantity;
      _price = product.price;
      _salesPrice = product.salePrice;
      _offer = product.offerPercentage;
    }
  }
}
