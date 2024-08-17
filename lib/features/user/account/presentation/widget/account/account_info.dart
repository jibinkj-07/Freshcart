import 'package:flutter/material.dart';
import '../../../../../../core/config/route/route_args_helper.dart';
import '../../../../../../core/config/route/route_mapper.dart';
import '../../../../../../core/util/widget/profile_avatar.dart';
import '../../../../../common/data/model/user_model.dart';
import '../../../../../common/presentation/bloc/auth_bloc.dart';
import '../account_widget_helper.dart';
import 'profile_section.dart';

/// @author : Jibin K John
/// @date   : 15/08/2024
/// @time   : 11:49:25

class AccountInfo extends StatelessWidget {
  final UserModel userInfo;
  final EmailStatus emailStatus;

  const AccountInfo({
    super.key,
    required this.userInfo,
    required this.emailStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileAvatar(
          onPressed: () => Navigator.of(context).pushNamed(
            RouteMapper.imagePreviewScreen,
            arguments: ImagePreviewArgument(
              title: userInfo.name,
              url: userInfo.imageUrl,
            ),
          ),
          imageUrl: userInfo.imageUrl,
        ),
        AccountWidgetHelper.spacer(),
        Text(
          userInfo.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          userInfo.email,
          style: const TextStyle(
            fontSize: 12.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        AccountWidgetHelper.spacer(height: 25.0),
        ProfileSection(emailStatus: emailStatus, email: userInfo.email),
      ],
    );
  }
}
