import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_cart/core/util/widget/outlined_text_field.dart';

import '../../../../../core/util/widget/animated_loading_button.dart';
import '../../data/model/category_model.dart';
import '../bloc/category_bloc.dart';

/// @author : Jibin K John
/// @date   : 20/08/2024
/// @time   : 16:04:10

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  String _title = "";
  String _description = "";

  @override
  void dispose() {
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
        title: const Text("Add Category"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              OutlinedTextField(
                textFieldKey: "title",
                isObscure: false,
                hintText: "Title",
                inputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: (data) {
                  if (data.toString().trim().isEmpty) {
                    return "Title is empty";
                  }
                  return null;
                },
                onSaved: (data) => _title = data.toString().trim(),
              ),
              const SizedBox(height: 20.0),
              OutlinedTextField(
                textFieldKey: "description",
                isObscure: false,
                minLines: 1,
                maxLines: 5,
                hintText: "Description [Optional]",
                inputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (data) => _description = data.toString().trim(),
              ),
              const SizedBox(height: 30.0),
              BlocListener<CategoryBloc, CategoryState>(
                listener: (ctx, state) {
                  _loading.value = state.status == CategoryStatus.adding;
                  if (state.error != null) {
                    state.error!.showSnackBar(context);
                  }
                  if (state.status == CategoryStatus.added) {
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
      ),
    );
  }

  void _onAdd() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      final category = CategoryModel(
        title: _title,
        description: _description,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      context.read<CategoryBloc>().add(AddCategory(category: category));
    }
  }
}
