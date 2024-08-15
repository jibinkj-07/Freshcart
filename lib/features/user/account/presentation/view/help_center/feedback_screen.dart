import 'package:flutter/material.dart';

import '../../../../../../core/util/widget/custom_snackbar.dart';
import '../../../../../../core/util/widget/custom_text_field.dart';
import '../../view_model/account_helper.dart';

/// @author : Jibin K John
/// @date   : 14/08/2024
/// @time   : 16:06:08

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final TextEditingController _feedback = TextEditingController();

  @override
  void dispose() {
    _feedback.dispose();
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
        title: const Text("Feedback"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Text(AccountHelper.feedbackTitle),
          AccountHelper.spacer(),
          Form(
            key: _formKey,
            child: CustomTextField(
              controller: _feedback,
              textFieldKey: 'feedback',
              isObscure: false,
              hintText: 'Feedback',
              inputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 10,
              minLines: 5,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return 'Enter some feedback';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20.0),
          ValueListenableBuilder(
            valueListenable: _loading,
            builder: (ctx, loading, child) {
              return FilledButton(
                onPressed: loading ? null : _onFeedbackSubmit,
                child: Text(loading ? "Submitting" : 'Submit'),
              );
            },
          ),
        ],
      ),
    );
  }

  // Validation function
  void _onFeedbackSubmit() {
    if (_formKey.currentState!.validate()) {
      _loading.value = true;
      FocusScope.of(context).unfocus();
      AccountHelper.submitFeedback(
        userId: "userId",
        feedback: _feedback.text,
      ).then(
        (value) {
          _loading.value = false;
          // Make sure that page is mounted before proceed
          if (!mounted) return;
          if (value.isRight) {
            CustomSnackBar.showSuccessSnackBar(
              context,
              "Feedback sent to development team",
            );
            _feedback.clear();
          } else {
            CustomSnackBar.showErrorSnackBar(context, value.left.message);
          }
        },
      );
    }
  }
}
