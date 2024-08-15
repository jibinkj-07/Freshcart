import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/util/widget/custom_snackbar.dart';
import '../../../../../../core/util/widget/custom_text_field.dart';
import '../../../../../common/presentation/bloc/user_bloc.dart';
import '../../view_model/account_helper.dart';
import '../../widget/account_widget_helper.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 16:05:30

class BugReportScreen extends StatefulWidget {
  const BugReportScreen({super.key});

  @override
  State<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends State<BugReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<File?> _image = ValueNotifier(null);
  final TextEditingController _bug = TextEditingController();

  @override
  void dispose() {
    _image.dispose();
    _bug.dispose();
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
        title: const Text("Report a Bug"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Text(AccountHelper.bugReportTitle),
          AccountWidgetHelper.spacer(),
          Form(
            key: _formKey,
            child: CustomTextField(
              controller: _bug,
              textFieldKey: 'bug',
              isObscure: false,
              hintText: 'Issue description',
              inputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 10,
              minLines: 5,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return 'Description is empty';
                }
                return null;
              },
            ),
          ),
          AccountWidgetHelper.spacer(),
          ValueListenableBuilder(
            valueListenable: _loading,
            builder: (ctx, loading, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: loading ? null : _pickImage,
                    child: const Text("Attach file"),
                  ),
                  FilledButton(
                    onPressed: loading ? null : _onReportSubmit,
                    child: Text(loading ? "Reporting" : "Report"),
                  ),
                ],
              );
            },
          ),
          AccountWidgetHelper.spacer(),
          ValueListenableBuilder(
            valueListenable: _image,
            builder: (ctx, image, child) {
              return image == null
                  ? child!
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () => _image.value = null,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    );
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // Validation function
  void _onReportSubmit() {
    if (_formKey.currentState!.validate()) {
      _loading.value = true;
      FocusScope.of(context).unfocus();
      final userBloc = context.read<UserBloc>();
      AccountHelper.reportBug(
        userId: userBloc.state.userDetail?.uid??"unknown_user",
        bug: _bug.text,
        image: _image.value,
      ).then((value) {
        _loading.value = false;
        // Make sure that page is mounted before proceed
        if (!mounted) return;
        if (value.isRight) {
          CustomSnackBar.showSuccessSnackBar(
            context,
            "Issue report to development team",
          );
          _image.value = null;
          _bug.clear();
        } else {
          CustomSnackBar.showErrorSnackBar(context, value.left.message);
        }
      });
    }
  }

  // Image Picker function from gallery
  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    _image.value = File(image.path);
  }
}
